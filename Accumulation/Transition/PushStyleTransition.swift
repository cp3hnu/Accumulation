//
//  PushStyleTransition.swift
//  hnup
//
//  Created by CP3 on 17/3/30.
//  Copyright © 2017年 DataYP. All rights reserved.
//

import UIKit

public final class PushStyleTransition: NSObject, UIViewControllerAnimatedTransitioning {
    public var isDismiss = false
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let toView: UIView = toVC.view
        let fromView: UIView = fromVC.view
        
        containerView.addSubview(toView)
        if !isDismiss {
            toView.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
        } else {
            containerView.sendSubviewToBack(toView)
            toView.frame = finalFrame.offsetBy(dx: -finalFrame.width/3.0, dy: 0)
        }
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            
            toView.frame = finalFrame
            if !self.isDismiss {
                fromView.frame = finalFrame.offsetBy(dx: -finalFrame.width/3.0, dy: 0)
            } else {
                fromView.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
            }
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
