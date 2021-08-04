//
//  OptionsPresentation.swift
//  hnup
//
//  Created by CP3 on 17/5/16.
//  Copyright © 2017年 DataYP. All rights reserved.
//

import UIKit

public final class OptionsPresentation: UIPresentationController {
    public var canDismiss = true
    public var offsetY: CGFloat = 0
    private let dimmingView1 = UIView().backgroundColor(UIColor.clear)
    private let dimmingView = UIView().backgroundColor(UIColor(white: 0.0, alpha: 0.6))

    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.alpha = 0.0
        dimmingView.addTapAction { [unowned self] in
            self.dismiss()
        }
        dimmingView1.addTapAction { [unowned self] in
            self.dismiss()
        }
    }
    
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        let frame = containerView!.frame
        dimmingView.frame = frame.offsetBy(dx: 0, dy: offsetY)
        dimmingView1.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: offsetY)
        dimmingView.alpha = 0.0
        
        containerView?.insertSubview(dimmingView1, at: 0)
        containerView?.insertSubview(dimmingView, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        let frame = containerView!.frame
        dimmingView1.frame = frame.offsetBy(dx: 0, dy: offsetY)
        dimmingView1.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: offsetY)
    }
    
    public func dismiss() {
        if canDismiss {
            presentingViewController.dismiss(animated: true, completion: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.OptionsDismiss, object: nil)
        }
    }
}
