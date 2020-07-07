//
//  LoadingView.swift
//  CPLoading
//
//  Created by ZhaoWei on 15/10/12.
//  Copyright © 2015年 CSDEPT. All rights reserved.
//

import UIKit
import RxSwift

open class LoadingView: UIView {
    private let disposeBag = DisposeBag()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.restartLoading()
                }
            ).disposed(by: disposeBag)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func startLoading() {}
    
    open func stopLoading() {}
    
    open func restartLoading() {}
}

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

public final class GradientLoadingView: LoadingView {
    private let imageView = UIImageView()
    public private(set) var isLoading = false
    public var duration: TimeInterval = 0.15
    
    public init(image: UIImage) {
        super.init(frame: CGRect.zero)
        
        imageView.image = image
        asv(imageView)
        imageView.fillContainer()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func startLoading() {
        guard !isLoading else { return }

        isLoading = true
        
        let from = CATransform3DIdentity
        let to = CATransform3DRotate(CATransform3DIdentity, 0.5 * .pi, 0, 0, 1)
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = from
        anim.toValue = to
        anim.repeatCount = Float.infinity
        anim.duration = duration
        anim.isCumulative = true
        
        imageView.layer.add(anim, forKey: "animation.rotate")
    }

    public override func stopLoading() {
        guard isLoading else { return }

        isLoading = false
        imageView.layer.removeAnimation(forKey: "animation.rotate")
    }
    
    public override func restartLoading() {
        guard isLoading else { return }

        isLoading = false
        startLoading()
    }
}





