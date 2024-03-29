//
//  UIFont+Style.swift
//  WordCard
//
//  Created by CP3 on 5/14/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    // UINavigationBar
    public struct NaviBar {
        /// title font
        static var title: UIFont {
            return 18.boldFont
        }
        
        /// UIBarButtonItem font
        static var barItem: UIFont {
            return 14.font
        }
    }
    
    /// 一般用于次要信息, 提示性文字, 10pt
    public static var ultraLightTextFont: UIFont {
        get {
            return 10.font
        }
    }
    
    /// 一般用于次要信息, 提示性文字, 12pt
    public static var lightTextFont: UIFont {
        get {
            return 12.font
        }
    }
    
    /// 标准文字, 一般用于正文, 文本内容, 14pt
    public static var contentFont: UIFont {
        get {
            return 14.font
        }
    }
    
    /// 一般用于标题, 重要性文字, 16pt
    public static var titleFont: UIFont {
        get {
            return 16.font
        }
    }
    
    /// 一般用于大号标题, 18pt
    public static var strongTitleFont: UIFont {
        get {
            return 18.font
        }
    }
}
