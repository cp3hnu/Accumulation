//
//  UISearchBar+Ext.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/6/10.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    // 设置 UISearchBar 里的 textField 的背景色
    public func setTextFieldBackgroundColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            self.searchTextField.backgroundColor = color
        } else {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        }
    }
    
    public func setTextFieldFont(_ font: UIFont) {
        if #available(iOS 13.0, *) {
            self.searchTextField.font = font
        } else {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = font
        }
    }
}
