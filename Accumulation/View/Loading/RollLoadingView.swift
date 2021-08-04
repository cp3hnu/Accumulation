//
//  RollLoadingView.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/6/10.
//  Copyright © 2021 CP3. All rights reserved.
//

import UIKit

public final class RollLoadingView: LoadingView {

    @IBInspectable public var lineWidth: CGFloat = 2.0 {
        didSet {
            ringLayer.lineWidth = lineWidth
        }
    }

    @IBInspectable public var radius: CGFloat = 5.0 {
        didSet {
            setLayerPath()
        }
    }

    @IBInspectable public var circleColor = UIColor.System.tint {
        didSet {
            circleLayer.fillColor = circleColor.cgColor
        }
    }
    
    @IBInspectable public var ringColor = UIColor.white.alpha(0.4) {
        didSet {
            ringLayer.strokeColor = ringColor.cgColor
        }
    }

    public var duration: TimeInterval = 1.0
    public private(set) var isLoading = false
    
    private let circleLayer: CAShapeLayer = CAShapeLayer()
    private let ringLayer: CAShapeLayer = CAShapeLayer()
    private let animationKey = "animation.rotation"

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let width = self.bounds.width
        let height = self.bounds.height
        ringLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        circleLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        setLayerPath()
    }
    
    public override func startLoading() {
        guard !isLoading else { return }

        isLoading = true
        circleLayer.removeAnimation(forKey: animationKey)

        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = duration
        animation.fromValue = 0.0
        animation.toValue = 2 * Double.pi
        animation.repeatCount = Float.infinity
        circleLayer.add(animation, forKey: animationKey)
    }

    public override func stopLoading() {
        guard isLoading else { return }

        isLoading = false
        circleLayer.removeAnimation(forKey: animationKey)
    }
    
    public override func restartLoading() {
        guard isLoading else { return }

        isLoading = false
        startLoading()
    }
}

// MARK: - Private
private extension RollLoadingView {
    func setupView() {
        // ringLayer
        ringLayer.strokeColor = ringColor.cgColor
        ringLayer.fillColor = nil
        ringLayer.lineWidth = lineWidth
        layer.addSublayer(ringLayer)

        // circleLayer
        circleLayer.strokeColor = nil
        circleLayer.fillColor = circleColor.cgColor
        layer.addSublayer(circleLayer)
    }

    func setLayerPath() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let ringRadius = min(bounds.width, bounds.height) / 2
        let ringPath = UIBezierPath(arcCenter: center, radius: ringRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(2 * Double.pi), clockwise: true)
        let circlePath = UIBezierPath(ovalIn: CGRect(x: bounds.width - radius, y: bounds.height/2 - radius, width: 2 * radius, height: 2 * radius))
        ringLayer.path = ringPath.cgPath
        circleLayer.path = circlePath.cgPath
    }
}
