//
//  DatePickerAnimator.swift
//  hnup
//
//  Created by CP3 on 16/6/1.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit

public final class DatePickerAnimator: NSObject, UIViewControllerTransitioningDelegate {
    
    private let animator: DatePickerTransition
    private let canDismiss: Bool
    public init(viewHeight: CGFloat, canDismiss: Bool = true) {
        self.canDismiss = canDismiss
        self.animator = DatePickerTransition(viewHeight: viewHeight)
        super.init()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismiss = false
        return animator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isDismiss = true
        return animator
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenter = DimmingPresentation(presentedViewController: presented, presenting: presenting)
        presenter.canDismiss = canDismiss
        return presenter
    }
}
