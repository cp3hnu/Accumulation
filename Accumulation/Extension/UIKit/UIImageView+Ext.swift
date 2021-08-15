//
//  UIImageView+Ext.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/6/8.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
import UIKit

/// 级联
extension UIImageView {
    @discardableResult
    public func contentMode(_ mode: ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
    
    @discardableResult
    public func clip(_ clipsToBounds: Bool = true) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
}

// 设置图片带动画效果
extension UIImageView {
    public func setImage(_ image: UIImage?, animation: Bool) {
        if animation {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
                self.image = image
            }
        } else {
            self.image = image
        }
    }
}

