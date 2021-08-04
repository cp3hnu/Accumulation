//
//  PushStyleAnimator.swift
//  hnup
//
//  Created by CP3 on 17/3/30.
//  Copyright © 2017年 DataYP. All rights reserved.
//

import UIKit

public final class PushStyleAnimator: NSObject, UIViewControllerTransitioningDelegate {
    private let animator = PushStyleTransition()
    private let interactiveAnimator = PushInteractiveTransition()
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveAnimator.wireToViewController(presented)
        animator.isDismiss = false
        return animator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismiss = true
        return animator
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? self.interactiveAnimator : nil
    }
}
