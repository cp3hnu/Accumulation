//
//  UIView+Animation.swift
//  Accumulation
//
//  Created by CP3 on 7/8/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 动画
extension UIView {
    public struct AnimationKey {
        public static var waggling = "animation.waggling"
        public static var scale = "animation.scale"
        public static var fadeTransition = "animation.fadeTransition"
        public static var rotate = "animation.rotate"
    }
    
    public func waggling(count: Int, tx: CGFloat = 15, ty: CGFloat = 0, duration: CFTimeInterval = 0.1) {
        let from = CATransform3DIdentity
        let to = CATransform3DTranslate(from, tx, ty, 0)
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = from
        anim.toValue = to
        anim.repeatCount = count.f
        anim.autoreverses = true
        anim.duration = duration/count.d
        
        self.layer.add(anim, forKey: AnimationKey.waggling)
    }
    
    public func scale(_ scale: CGFloat, duration: CFTimeInterval = 0.3) {
        let from = CATransform3DIdentity
        let to = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = from
        anim.toValue = to
        anim.autoreverses = true
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        self.layer.add(anim, forKey: AnimationKey.scale)
    }
    
    public func fadeTransition(duration: CFTimeInterval = 0.3) {
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        anim.type = CATransitionType.fade
        anim.duration = duration
        
        self.layer.add(anim, forKey: AnimationKey.fadeTransition)
    }
    
    public func rotate(angle: Double = 2 * Double.pi, count: Int = 0, duration: CFTimeInterval = 1.0) {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.fromValue = 0.0
        anim.toValue = angle
        anim.duration = duration
        if count == 0 {
            anim.isRemovedOnCompletion = false
            anim.repeatCount = Float.infinity
        } else {
            anim.repeatCount = count.f
        }
        
        self.layer.add(anim, forKey: AnimationKey.rotate)
    }
}
