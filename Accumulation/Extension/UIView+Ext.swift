//
//  UIView+Ext.swift
//  Cards
//
//  Created by CP3 on 17/5/10.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit
import Bricking

// MARK: - Cascade
extension UIView {
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    public func border(width: CGFloat, color: UIColor) -> Self {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func corner(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }
}

// MARK: - Seperator
extension UIView {
    public static func seperator(color: UIColor = UIColor.seperatorColor) -> UIView {
        return UIView().backgroundColor(color)
    }
}

// MARK: - Snapshot
extension UIView {
    public var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - 设置边框的颜色8z
extension UIView {
    public enum Border {
        case left
        case right
        case top
        case bottom
    }
    
    public func setBorder(border: UIView.Border, weight: CGFloat, color: UIColor ) {
        let lineView = UIView()
        lineView.backgroundColor = color
        asv(lineView)
        
        switch border {
        case .left:
            |lineView.width(weight).fillVertically()
        case .right:
            lineView.width(weight).fillVertically()|
        case .top:
            |lineView.top(0).height(weight)|
        case .bottom:
            |lineView.bottom(0).height(weight)|
        }
    }
}

// MARK: - 添加渐变色和边角
extension UIView {
    public func addGradientColor(bounds: CGRect, fromColor: UIColor, toColor: UIColor ) {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.startPoint = CGPoint.zero
        layer.endPoint = CGPoint(x: 0, y: 1.0)
        layer.colors = [fromColor.cgColor, toColor.cgColor]
        self.layer.addSublayer(layer)
    }
    
    public func addCorner(bounds: CGRect, cornerRadii: CGSize, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

// MARK: - 动画
extension UIView {
    public func waggling() {
        let from = CATransform3DIdentity
        let to = CATransform3DTranslate(from, 15, 0, 0)
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = from
        anim.toValue = to
        anim.repeatCount = 3
        anim.autoreverses = true
        anim.duration = 0.1/3.0
        
        self.layer.add(anim, forKey: "animation.waggling")
    }
    
    public func scaleUp(_ scale: CGFloat, duration: CFTimeInterval = 0.3) {
        let from = CATransform3DIdentity
        let to = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = from
        anim.toValue = to
        anim.autoreverses = true
        anim.duration = 0.3
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        self.layer.add(anim, forKey: "animation.scaleUp")
    }
    
    public func fadeTransition(_ duration: CFTimeInterval = 0.3) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: "animation.fadeTransition")
    }
    
    public func fadeInOut() {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 1
        anim.toValue = 0
        anim.autoreverses = true
        anim.duration = 1
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        anim.repeatCount = Float.infinity
        
        self.layer.add(anim, forKey: "animation.fadeInOut")
    }
}
