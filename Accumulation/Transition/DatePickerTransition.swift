//
//  DatePickerTransition.swift
//  hnup
//
//  Created by CP3 on 16/6/1.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit

public final class DatePickerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isDismiss = false
    private let viewHeight: CGFloat
    init(viewHeight: CGFloat) {
        self.viewHeight = viewHeight
        super.init()
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let fromFrame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        let toView: UIView = toVC.view
        let fromView: UIView = fromVC.view
        
        if !isDismiss {
            toView.frame = fromFrame
            containerView.addSubview(toView)
        }
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            if !self.isDismiss {
                toView.frame = fromFrame.offsetBy(dx: 0, dy: -self.viewHeight)
            } else {
                fromView.frame = fromFrame
            }
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
