//
//  DimmingAnimator.swift
//  hnup
//
//  Created by CP3 on 16/6/23.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit

final class DimmingAnimator: NSObject, UIViewControllerTransitioningDelegate {
    private let canDismiss: Bool
    init(canDismiss: Bool = true) {
        self.canDismiss = canDismiss
        super.init()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenter = DimmingPresentation(presentedViewController: presented, presenting: presenting)
        presenter.canDismiss = canDismiss
        return presenter
    }
}
