//
//  AlertTransition.swift
//  WordCard
//
//  Created by CP3 on 5/11/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

typealias AlertStyleCtrlr = AlertStyleViewController & UIViewController

public final class AlertTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isDismiss = false
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView: UIView = toVC.view
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        var alertCtrlr: AlertStyleCtrlr?
        
        let duration = transitionDuration(using: transitionContext)
        if !isDismiss {
            toView.frame = finalFrame
            containerView.addSubview(toView)
            alertCtrlr = toVC as? AlertStyleCtrlr
        } else {
            alertCtrlr = fromVC as? AlertStyleCtrlr
        }
        
        if let alert = alertCtrlr {
            let wrappedView = alert.wrappedView
            if !isDismiss {
                wrappedView.alpha = 0
                wrappedView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
                wrappedView.alpha = 1.0
                wrappedView.transform = CGAffineTransform.identity
            }
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                if !self.isDismiss {
                    wrappedView.alpha = 1.0
                    wrappedView.transform = CGAffineTransform.identity
                } else {
                    wrappedView.alpha = 0
                    wrappedView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
