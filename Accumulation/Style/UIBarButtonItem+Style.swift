//
//  UIBarButtonItem+Ext.swift
//  WordCard
//
//  Created by CP3 on 4/8/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
extension UIBarButtonItem {
    /// 导航条上 system image 的配置
    public static var imageSysConfig: UIImage.SymbolConfiguration {
        return UIImage.SymbolConfiguration(pointSize: 16, weight: UIImage.SymbolWeight.semibold, scale: UIImage.SymbolScale.large)
    }
}

