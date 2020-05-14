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
    struct System {
        /// tint color
        static var tint: UIColor {
            return UIColor(0, 122, 255)
        }
        
        /// UITableViewCell seperator color
        static var cellSeperator: UIColor {
            return UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
        }
        
        /// UITextField placeholder color
        static var placeholder: UIColor {
            return UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.22)
        }
        
        /// UINavigationBar seperator color
        static var naviBarSeperator: UIColor {
            return UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        }
    }
    
    struct Text {
        /// 重要文字，0x333333
        static var strong: UIColor {
            return 0x333333.hexColor
        }
        
        /// 一般文字，0x666666
        static var regular: UIColor {
            return 0x666666.hexColor
        }
        
        /// 次级文字，0x888888
        static var light: UIColor {
            return 0x888888.hexColor
        }
        
        /// 极弱文字，0xBBBBBB
        static var ultraLight: UIColor {
            return 0xBBBBBB.hexColor
        }
    }
    
    /// UINavigationBar
    struct NaviBar {
        /// title color
        static var title: UIColor {
            return UIColor.mainColor
        }
        
        /// tint color
        static var barTint: UIColor {
            return 0x333333.hexColor
        }
        
        /// tint color
        static var tint: UIColor {
            return UIColor.mainColor
        }
        
        /// UIBarButtonItem normal text color
        static var barItemForNormal: UIColor {
            return UIColor.NaviBar.tint
        }
        
        /// UIBarButtonItem highlighted text color
        static var barItemForHighlighted: UIColor {
            return UIColor.mainColor
        }
        
        /// UIBarButtonItem disabled text color
        static var barItemForDisabled: UIColor {
            return UIColor.lightGray.alpha(0.5)
        }
    }
    
    /// 主色调
    static var mainColor: UIColor {
        return 0x4497FF.hexColor
    }
    
    /// URL链接颜色
    static var urlLinkColor: UIColor {
        return 0x4497FF.hexColor
    }
    
    /// 分隔线颜色，(221, 221, 221)
    static var seperatorColor: UIColor {
        return 221.grayColor
    }
    
    /// 背景颜色，(245, 245, 245)
    static var backgroudColor: UIColor {
        return 245.grayColor
    }
    
    /// 常用按钮字体颜色，(105, 68, 24)
    static var buttonTextColor: UIColor {
        return UIColor(105, 68, 24)
    }
    
    /// 边线颜色
    static var borderColor: UIColor {
        return 221.grayColor
    }
    
    /// 正确颜色
    static var correctColor: UIColor {
        return 0x07C160.hexColor
    }
    
    /// 错误颜色
    static var wrongColor: UIColor {
        return 0xFF4545.hexColor
    }
}
