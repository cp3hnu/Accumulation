//
//  OptionsTransition.swift
//  hnup
//
//  Created by CP3 on 17/5/16.
//  Copyright © 2017年 DataYP. All rights reserved.
//

import UIKit

public final class OptionsTransition: NSObject, UIViewControllerAnimatedTransitioning {
    public var isDismiss = false
    private let offsetY: CGFloat
    private let height: CGFloat
    public init(offsetY: CGFloat, height: CGFloat) {
        self.offsetY = offsetY
        self.height = height
        super.init()
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        let toView: UIView = toVC.view
        let fromView: UIView = fromVC.view
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let fromFrame = CGRect(x: finalFrame.origin.x, y: -self.height, width: finalFrame.width, height: self.height)
        let middleFrame = CGRect(x: finalFrame.origin.x, y: 0, width: finalFrame.width, height: self.height)
        let contentView = UIView().backgroundColor(UIColor.clear)
        contentView.frame = CGRect(x: finalFrame.origin.x, y: offsetY, width: finalFrame.width, height: finalFrame.height - offsetY)
        contentView.clipsToBounds = true
        
        if !isDismiss {
            toView.frame = fromFrame
            containerView.addSubview(contentView)
            contentView.addSubview(toView)
        } else {
            fromView.removeFromSuperview()
            fromView.frame = middleFrame
            containerView.addSubview(contentView)
            contentView.addSubview(fromView)
        }
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            if !self.isDismiss {
                toView.frame = middleFrame
            } else {
                fromView.frame = fromFrame
            }
            }, completion: { finished in
                if !self.isDismiss {
                    toView.removeFromSuperview()
                    contentView.removeFromSuperview()
                    toView.frame = CGRect(x: finalFrame.origin.x, y: self.offsetY, width: finalFrame.width, height: self.height)
                    containerView.addSubview(toView)
                } else {
                    contentView.removeFromSuperview()
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
