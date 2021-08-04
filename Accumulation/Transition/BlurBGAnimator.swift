//
//  BlurBGAnimator.swift
//  Cards
//
//  Created by CP3 on 2018/8/17.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit

public final class BlurBGAnimator: NSObject, UIViewControllerTransitioningDelegate {
    
    private let canDismiss: Bool
    public init(canDismiss: Bool = true) {
        self.canDismiss = canDismiss
        super.init()
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenter = BlurBGPresentation(presentedViewController: presented, presenting: presenting)
        presenter.canDismiss = canDismiss
        return presenter
    }
}
