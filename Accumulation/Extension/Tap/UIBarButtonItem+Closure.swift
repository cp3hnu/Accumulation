//
//  UIBarButtonItem+Ext.swift
//  Cards
//
//  Created by CP3 on 2018/5/21.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 添加Tap Block
extension UIBarButtonItem {
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
    
    public convenience init(image: UIImage?, style: UIBarButtonItem.Style, block: TapAction? = nil) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(UIBarButtonItem.tapped)
        self.tapAction = block
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, block: TapAction? = nil) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(UIBarButtonItem.tapped)
        self.tapAction = block
    }
    
    public convenience init(title: String?, style: UIBarButtonItem.Style, block: TapAction? = nil) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(UIBarButtonItem.tapped)
        self.tapAction = block
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, block: TapAction? = nil) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.target = self
        self.action = #selector(UIBarButtonItem.tapped)
        self.tapAction = block
    }
    
    @objc private func tapped() {
        tapAction?()
    }
}

