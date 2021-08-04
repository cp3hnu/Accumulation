//
//  UIColor+Style.swift
//  WordCard
//
//  Created by CP3 on 11/6/19.
//  Copyright © 2019 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // 系统默认
    public struct System {
        /// tint color
        public static var tint: UIColor {
            return UIColor(0, 122, 255)
        }
        
        /// UITableViewCell separator color
        public static var cellSeparator: UIColor {
            return UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
        }
        
        /// UITextField placeholder color
        public static var placeholder: UIColor {
            return UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.22)
        }
        
        /// UINavigationBar separator color
        public static var naviBarSeparator: UIColor {
            return UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        }
    }
    
    public struct Text {
        /// 重要文字，0x333333
        public static var strong: UIColor {
            return 0x333333.hexColor
        }
        
        /// 一般文字，0x666666
        public static var regular: UIColor {
            return 0x666666.hexColor
        }
        
        /// 次级文字，0x999999
        public static var light: UIColor {
            return 0x999999.hexColor
        }
        
        /// 极弱文字，0xBBBBBB
        public static var ultraLight: UIColor {
            return 0xBBBBBB.hexColor
        }
    }
    
    /// UINavigationBar
    public struct NaviBar {
        /// title color
        public static var title: UIColor {
            return UIColor.mainColor
        }
        
        /// bar tint color
        public static var barTint: UIColor {
            return 0x333333.hexColor
        }
        
        /// tint color
        public static var tint: UIColor {
            return UIColor.mainColor
        }
        
        /// UIBarButtonItem normal text color
        public static var barItemForNormal: UIColor {
            return UIColor.NaviBar.tint
        }
        
        /// UIBarButtonItem highlighted text color
        public static var barItemForHighlighted: UIColor {
            return UIColor.mainColor
        }
        
        /// UIBarButtonItem disabled text color
        public static var barItemForDisabled: UIColor {
            return UIColor.lightGray.alpha(0.5)
        }
    }
    
    /// 主色调
    public static var mainColor: UIColor {
        return 0x516FDF.hexColor
    }
    
    /// URL链接颜色
    public static var urlLinkColor: UIColor {
        return 0x4497FF.hexColor
    }
    
    /// 常用按钮字体颜色，(105, 68, 24)
    public static var buttonTextColor: UIColor {
        return UIColor(105, 68, 24)
    }
    
    /// 边线颜色
    public static var borderColor: UIColor {
        return 221.grayColor
    }
    
    /// 正确颜色
    public static var correctColor: UIColor {
        return 0x07C160.hexColor
    }
    
    /// 错误颜色
    public static var wrongColor: UIColor {
        return 0xFF4545.hexColor
    }
    
    // X 关闭颜色
    public static var dynamicCloseColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.white : 0x333333.hexColor
            }
        } else {
            return 0x333333.hexColor
        }
    }
    
    // 自定义的 SecondaryLabel 颜色
    public static var dynamicSecondaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? 0xebebf5.hexColor : 0x333333.hexColor
            }
        } else {
            return 0x333333.hexColor
        }
    }
}

// 为了兼容
extension UIColor {
    public static var compLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return 0x000000.hexColor
        }
    }
    
    public static var compSecondaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return 0x3c3c43.hexColor.alpha(0.6)
        }
    }
    
    public static var compTertiaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiaryLabel
        } else {
            return 0x3c3c43.hexColor.alpha(0.3)
        }
    }
    
    public static var compSecondarySystemGroupedBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemGroupedBackground
        } else {
            return UIColor.white
        }
    }
    
    public static var compSecondarySystemBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground
        } else {
            return 0xf2f2f7.hexColor
        }
    }
    
    public static var compTertiarySystemGroupedBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemGroupedBackground
        } else {
            return 0xf2f2f7.hexColor
        }
    }
    
    public static var compTertiarySystemBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemBackground
        } else {
            return UIColor.white
        }
    }
    
    public static var compSeparator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.separator
        } else {
            return 0x3c3c43.hexColor.alpha(0.29)
        }
    }
    
    public static var compPlaceholderText: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.placeholderText
        } else {
            return 0x3c3c43.hexColor.alpha(0.3)
        }
    }
    
    public static var compSystemBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return UIColor.white
        }
    }
}
