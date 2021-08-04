//
//  PushInteractiveTransition.swift
//  Cards
//
//  Created by CP3 on 2018/5/21.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit

public final class PushInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    public var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var controller: UIViewController?
    
    func wireToViewController(_ ctrlr: UIViewController) {
        controller = ctrlr
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan))
        pan.edges = .left
        ctrlr.view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        guard let navCtrlr = controller as? UINavigationController, navCtrlr.viewControllers.count == 1 else { return }
        
        let point = sender.translation(in: navCtrlr.view)
        switch sender.state {
        case .began:
            interactionInProgress = true
            navCtrlr.dismiss(animated: true, completion: nil)
        case .changed:
            let width = navCtrlr.view.bounds.width
            let fraction = point.x/width
            shouldCompleteTransition = fraction > 0.5
            update(fraction)
        case .ended, .cancelled:
            interactionInProgress = false
            if !shouldCompleteTransition || sender.state == .cancelled {
                cancel()
            } else {
                finish()
            }
        default:
            break
        }
    }
}
