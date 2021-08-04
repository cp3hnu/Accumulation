//
//  BlurBGPresentation.swift
//  Cards
//
//  Created by CP3 on 2018/8/17.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit

public final class BlurBGPresentation: UIPresentationController {
    
    var canDismiss = true
    private let effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    private let dimmingView = UIVisualEffectView()
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.addTapAction { [unowned self] in
            self.dismiss()
        }
    }
    
    override public func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        dimmingView.frame = containerView!.frame
        
        containerView?.insertSubview(dimmingView, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.effect = self.effect
        }, completion: nil)
    }
    
    override public func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.effect = nil
        }, completion: nil)
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimmingView.frame = containerView!.frame
    }
}

private extension BlurBGPresentation {
    func dismiss() {
        if canDismiss {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
