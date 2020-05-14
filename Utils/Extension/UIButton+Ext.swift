//
//  UIButton+Ext.swift
//  Configuration
//
//  Created by CP3 on 11/4/19.
//  Copyright © 2019 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    /// 可以设置高亮时的背景色
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(color.image, for: state)
    }
}


