//
//  DOFavoriteButton.swift
//  DOFavoriteButton
//
//  Created by Daiki Okumura on 2015/07/09.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

public class DOFavoriteButton: UIButton {

    public var image: UIImage {
        didSet {
            createLayers()
        }
    }
    public var imageColorOn: UIColor = UIColor.blue {
        didSet {
            if (isSelected) {
                imageShape.fillColor = imageColorOn.cgColor
            }
        }
    }
    public var imageColorOff: UIColor = UIColor.black {
        didSet {
            if (!isSelected) {
                imageShape.fillColor = imageColorOff.cgColor
            }
        }
    }

    public var circleColor: UIColor = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0) {
        didSet {
            circleShape.fillColor = circleColor.cgColor
        }
    }
    
    public var lineColor: UIColor = UIColor(red: 250/255, green: 120/255, blue: 68/255, alpha: 1.0) {
        didSet {
            for line in lines {
                line.strokeColor = lineColor.cgColor
            }
        }
    }
    
    public var duration: Double = 1.0 {
        didSet {
            circleTransform.duration = 0.333 * duration // 0.0333 * 10
            circleMaskTransform.duration = 0.333 * duration // 0.0333 * 10
            lineStrokeStart.duration = 0.6 * duration //0.0333 * 18
            lineStrokeEnd.duration = 0.6 * duration //0.0333 * 18
            lineOpacity.duration = 1.0 * duration //0.0333 * 30
            imageTransform.duration = 1.0 * duration //0.0333 * 30
        }
    }

    private let imageShape = CAShapeLayer()
    private let imageMask = CALayer()
    private let circleShape = CAShapeLayer()
    private let circleMask = CAShapeLayer()
    private let lines: [CAShapeLayer]
    private let circleTransform = CAKeyframeAnimation(keyPath: "transform")
    private let circleMaskTransform = CAKeyframeAnimation(keyPath: "transform")
    private let lineStrokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
    private let lineStrokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
    private let lineOpacity = CAKeyframeAnimation(keyPath: "opacity")
    private let imageTransform = CAKeyframeAnimation(keyPath: "transform")
    
    override public var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
               
            if isSelected {
                imageShape.fillColor = imageColorOn.cgColor
            } else {
                imageShape.fillColor = imageColorOff.cgColor
            }
        }
    }

    public init(image: UIImage) {
        self.image = image
        self.lines = (0..<5).map { _ in return CAShapeLayer() }
        super.init(frame: .zero)
        createLayers()
        addTargets()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setLayersFrame()
    }
    
    private func createLayers() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        //===============
        // circle layer
        //===============
        circleShape.fillColor = circleColor.cgColor
        circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
        self.layer.addSublayer(circleShape)

        circleMask.fillRule = CAShapeLayerFillRule.evenOdd
        circleShape.mask = circleMask

        //===============
        // line layer
        //===============
        for (idx, line) in lines.enumerated() {
            line.masksToBounds = true
            line.actions = ["strokeStart": NSNull(), "strokeEnd": NSNull()]
            line.strokeColor = lineColor.cgColor
            line.lineWidth = 1.25
            line.miterLimit = 1.25
            line.lineCap = CAShapeLayerLineCap.round
            line.lineJoin = CAShapeLayerLineJoin.round
            line.strokeStart = 0.0
            line.strokeEnd = 0.0
            line.opacity = 0.0
            line.transform = CATransform3DMakeRotation(CGFloat.pi / 5 * (CGFloat(idx) * 2 + 1), 0.0, 0.0, 1.0)
            self.layer.addSublayer(line)
        }

        //===============
        // image layer
        //===============
        imageShape.fillColor = imageColorOff.cgColor
        imageShape.actions = ["fillColor": NSNull()]
        self.layer.addSublayer(imageShape)

        imageMask.contents = image.cgImage
        imageShape.mask = imageMask
        
        //==============================
        // circle transform animation
        //==============================
        circleTransform.duration = 0.333 // 0.0333 * 10
        circleTransform.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.0,  0.0,  1.0)),    //  0/10
            NSValue(caTransform3D: CATransform3DMakeScale(0.5,  0.5,  1.0)),    //  1/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.0,  1.0,  1.0)),    //  2/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.2,  1.2,  1.0)),    //  3/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.3,  1.3,  1.0)),    //  4/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.37, 1.37, 1.0)),    //  5/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0)),    //  6/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0))     // 10/10
        ]
        circleTransform.keyTimes = [
            0.0,    //  0/10
            0.1,    //  1/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            1.0     // 10/10
        ]

        let imageWidth = image.size.width
        let imageHeight = image.size.height
        circleMaskTransform.duration = 0.333 // 0.0333 * 10
        circleMaskTransform.values = [
            NSValue(caTransform3D: CATransform3DIdentity),                                                              //  0/10
            NSValue(caTransform3D: CATransform3DIdentity),                                                              //  2/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 1.25,  imageHeight * 1.25,  1.0)),   //  3/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 2.688, imageHeight * 2.688, 1.0)),   //  4/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 3.923, imageHeight * 3.923, 1.0)),   //  5/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 4.375, imageHeight * 4.375, 1.0)),   //  6/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 4.731, imageHeight * 4.731, 1.0)),   //  7/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 5.0,   imageHeight * 5.0,   1.0)),   //  9/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageWidth * 5.0,   imageHeight * 5.0,   1.0))    // 10/10
        ]
        circleMaskTransform.keyTimes = [
            0.0,    //  0/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            0.7,    //  7/10
            0.9,    //  9/10
            1.0     // 10/10
        ]

        //==============================
        // line stroke animation
        //==============================
        lineStrokeStart.duration = 0.6 //0.0333 * 18
        lineStrokeStart.values = [
            0.0,    //  0/18
            0.0,    //  1/18
            0.18,   //  2/18
            0.2,    //  3/18
            0.26,   //  4/18
            0.32,   //  5/18
            0.4,    //  6/18
            0.6,    //  7/18
            0.71,   //  8/18
            0.89,   // 17/18
            0.92    // 18/18
        ]
        lineStrokeStart.keyTimes = [
            0.0,    //  0/18
            0.056,  //  1/18
            0.111,  //  2/18
            0.167,  //  3/18
            0.222,  //  4/18
            0.278,  //  5/18
            0.333,  //  6/18
            0.389,  //  7/18
            0.444,  //  8/18
            0.944,  // 17/18
            1.0,    // 18/18
        ]

        lineStrokeEnd.duration = 0.6 //0.0333 * 18
        lineStrokeEnd.values = [
            0.0,    //  0/18
            0.0,    //  1/18
            0.32,   //  2/18
            0.48,   //  3/18
            0.64,   //  4/18
            0.68,   //  5/18
            0.92,   // 17/18
            0.92    // 18/18
        ]
        lineStrokeEnd.keyTimes = [
            0.0,    //  0/18
            0.056,  //  1/18
            0.111,  //  2/18
            0.167,  //  3/18
            0.222,  //  4/18
            0.278,  //  5/18
            0.944,  // 17/18
            1.0,    // 18/18
        ]

        lineOpacity.duration = 1.0 //0.0333 * 30
        lineOpacity.values = [
            1.0,    //  0/30
            1.0,    // 12/30
            0.0     // 17/30
        ]
        lineOpacity.keyTimes = [
            0.0,    //  0/30
            0.4,    // 12/30
            0.567   // 17/30
        ]

        //==============================
        // image transform animation
        //==============================
        imageTransform.duration = 1.0 //0.0333 * 30
        imageTransform.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)),  //  0/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)),  //  3/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)),  //  9/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.25,  1.25,  1.0)),  // 10/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)),  // 11/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)),  // 14/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)),  // 15/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)),  // 16/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)),  // 17/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)),  // 20/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.025, 1.025, 1.0)),  // 21/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)),  // 22/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)),  // 25/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.95,  0.95,  1.0)),  // 26/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)),  // 27/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.99,  0.99,  1.0)),  // 29/30
            NSValue(caTransform3D: CATransform3DIdentity)                       // 30/30
        ]
        imageTransform.keyTimes = [
            0.0,    //  0/30
            0.1,    //  3/30
            0.3,    //  9/30
            0.333,  // 10/30
            0.367,  // 11/30
            0.467,  // 14/30
            0.5,    // 15/30
            0.533,  // 16/30
            0.567,  // 17/30
            0.667,  // 20/30
            0.7,    // 21/30
            0.733,  // 22/30
            0.833,  // 25/30
            0.867,  // 26/30
            0.9,    // 27/30
            0.967,  // 29/30
            1.0     // 30/30
        ]
    }
    

    private func setLayersFrame() {
        let imageFrame = bounds
        let imgCenterPoint = CGPoint(x: imageFrame.midX, y: imageFrame.midY)
        let lineFrame = CGRect(x: imageFrame.origin.x - imageFrame.width / 4, y: imageFrame.origin.y - imageFrame.height / 4 , width: imageFrame.width * 1.5, height: imageFrame.height * 1.5)

        //===============
        // circle layer
        //===============
        circleShape.bounds = imageFrame
        circleShape.position = imgCenterPoint
        circleShape.path = UIBezierPath(ovalIn: imageFrame).cgPath

        circleMask.bounds = imageFrame
        circleMask.position = imgCenterPoint
        circleMask.path = {
            let path = UIBezierPath(rect: imageFrame)
            path.addArc(withCenter: imgCenterPoint, radius: 0.1, startAngle: CGFloat(0.0), endAngle: CGFloat.pi * 2, clockwise: true)
            return path.cgPath
        }()

        //===============
        // line layer
        //===============
        for line in lines {
            line.bounds = lineFrame
            line.position = imgCenterPoint
            line.path = {
                let path = CGMutablePath()
                path.move(to: CGPoint(x: lineFrame.midX, y: lineFrame.midY))
                path.addLine(to: CGPoint(x: lineFrame.origin.x + lineFrame.width / 2, y: lineFrame.origin.y))
                return path
                }()
        }

        //===============
        // image layer
        //===============
        imageShape.bounds = imageFrame
        imageShape.position = imgCenterPoint
        imageShape.path = UIBezierPath(rect: imageFrame).cgPath
     
        imageMask.bounds = imageFrame
        imageMask.position = imgCenterPoint
    }

    private func addTargets() {
        //===============
        // add target
        //===============
        self.addTarget(self, action: #selector(DOFavoriteButton.touchDown(_:)), for: UIControl.Event.touchDown)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchUpInside(_:)), for: UIControl.Event.touchUpInside)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchDragExit(_:)), for: UIControl.Event.touchDragExit)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchDragEnter(_:)), for: UIControl.Event.touchDragEnter)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchCancel(_:)), for: UIControl.Event.touchCancel)
    }

    @objc func touchDown(_ sender: DOFavoriteButton) {
        self.layer.opacity = 0.4
    }
    @objc func touchUpInside(_ sender: DOFavoriteButton) {
        self.layer.opacity = 1.0
    }
    @objc func touchDragExit(_ sender: DOFavoriteButton) {
        self.layer.opacity = 1.0
    }
    @objc func touchDragEnter(_ sender: DOFavoriteButton) {
        self.layer.opacity = 0.4
    }
    @objc func touchCancel(_ sender: DOFavoriteButton) {
        self.layer.opacity = 1.0
    }

    public func select() {
        isSelected = true

        CATransaction.begin()
        circleShape.add(circleTransform, forKey: "transform")
        circleMask.add(circleMaskTransform, forKey: "transform")
        imageShape.add(imageTransform, forKey: "transform")
        lines.forEach {
            $0.add(lineStrokeStart, forKey: "strokeStart")
            $0.add(lineStrokeEnd, forKey: "strokeEnd")
            $0.add(lineOpacity, forKey: "opacity")
        }
        CATransaction.commit()
    }

    public func deselect() {
        isSelected = false

        // remove all animations
        circleShape.removeAllAnimations()
        circleMask.removeAllAnimations()
        imageShape.removeAllAnimations()
        lines.forEach { $0.removeAllAnimations() }
    }
}
