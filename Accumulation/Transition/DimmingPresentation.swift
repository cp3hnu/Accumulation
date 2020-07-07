//
//  DimmingPresentation.swift
//  hnup
//
//  Created by CP3 on 16/6/1.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit

public final class DimmingPresentation: UIPresentationController {
    
    var canDismiss = true
    var alpha: CGFloat = 0.65 {
        didSet {
            dimmingView.backgroundColor = UIColor(white: 0.0, alpha: alpha)
        }
    }
    private let dimmingView = UIView()
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: alpha)
        dimmingView.alpha = 0.0
        dimmingView.addTapAction { [unowned self] in
            self.dismiss()
        }
    }
    
    override public func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        dimmingView.frame = containerView!.frame
        dimmingView.alpha = 0.0
        
        containerView?.insertSubview(dimmingView, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    override public func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimmingView.frame = containerView!.frame
    }
}

private extension DimmingPresentation {
    func dismiss() {
        if canDismiss {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
