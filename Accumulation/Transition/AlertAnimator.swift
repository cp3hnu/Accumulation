//
//  AlertAnimator.swift
//  WordCard
//
//  Created by CP3 on 5/11/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

public final class AlertAnimator: NSObject, UIViewControllerTransitioningDelegate {
    
    public var bgColorAlpha: CGFloat = 0.3
    private let canDismiss: Bool
    private let animator: AlertTransition
    
    public init(canDismiss: Bool = false) {
        self.canDismiss = canDismiss
        self.animator = AlertTransition()
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
        presenter.bgColorAlpha = bgColorAlpha
        return presenter
    }
}
