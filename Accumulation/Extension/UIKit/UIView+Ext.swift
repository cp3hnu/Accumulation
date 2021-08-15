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
    
    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}

// MARK: - Separator
extension UIView {
    public static func separator(color: UIColor = UIColor.compSeparator) -> UIView {
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

// MARK: - 设置边框的颜色
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
