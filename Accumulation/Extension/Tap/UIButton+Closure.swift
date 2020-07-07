//
//  UIButton+Ext.swift
//  Cards
//
//  Created by CP3 on 2017/9/27.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 添加Tap Block
extension UIButton {
    private struct AssociatedKeys {
        static var tapAction = "tapAction"
    }
    
    private var tapAction: TapAction? {
        get {
            if let cw = objc_getAssociatedObject(self, &AssociatedKeys.tapAction) as? TapActionWrapper {
                return cw.action
            }
            return nil
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.tapAction, TapActionWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func tap(_ action: @escaping TapAction) {
        tapAction = action
        addTarget(self, action: #selector(UIButton.tapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func tapped() {
        tapAction?()
    }
}
