//
//  UIView+Closure.swift
//  WordCard
//
//  Created by CP3 on 11/5/19.
//  Copyright © 2019 CP3. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIView {
    private struct AssociatedKeys {
        static var tapGestureAction = "tapGestureAction"
    }
    
    private var tapGestureAction: TapAction? {
        get {
            if let cw = objc_getAssociatedObject(self, &AssociatedKeys.tapGestureAction) as? TapActionWrapper {
                return cw.action
            }
            return nil
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.tapGestureAction, TapActionWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func addTapAction(_ action: TapAction?) {
        tapGestureAction = action
        self.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(UIView.tapGRAction))
        self.addGestureRecognizer(tapGR)
    }
    
    @objc private func tapGRAction(gr: UITapGestureRecognizer) {
        guard gr.state == .ended else { return }
        tapGestureAction?()
    }
}
