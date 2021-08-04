//
//  OptionsAnimator.swift
//  hnup
//
//  Created by CP3 on 17/5/16.
//  Copyright © 2017年 DataYP. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let OptionsDismiss = NSNotification.Name(rawValue: "Notification_Options_Dismiss")
}

public final class OptionsAnimator: NSObject, UIViewControllerTransitioningDelegate {
    private let animator: OptionsTransition
    private let canDismiss: Bool
    private let offsetY: CGFloat
    private let height: CGFloat
    
    public init(offsetY: CGFloat, height: CGFloat, canDismiss: Bool = true) {
        self.offsetY = offsetY
        self.height = height
        self.canDismiss = canDismiss
        self.animator = OptionsTransition(offsetY: offsetY, height: height)
        super.init()
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismiss = false
        return animator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismiss = true
        return animator
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenter = OptionsPresentation(presentedViewController: presented, presenting: presenting)
        presenter.canDismiss = canDismiss
        presenter.offsetY = offsetY
        return presenter
    }
}
