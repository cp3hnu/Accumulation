//
//  Number+Ext.swift
//  Cards
//
//  Created by CP3 on 2018/1/17.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 数据格式直接的转换
extension Double {
    public var twoDecimalPlaces: String { String(format: "%.2f", self) }
    public var cf: CGFloat { CGFloat(self) }
    public var i: Int { Int(self) }
}

extension Int {
    public var cf: CGFloat { CGFloat(self) }
    public var f: Float { Float(self) }
    public var d: Double { Double(self) }
}

extension Float {
    public var cf: CGFloat { CGFloat(self) }
}

extension CGFloat {
    public var d: Double { Double(self) }
    public var f: Float { Float(self) }
    public var i: Int {  Int(self) }
}

// MARK: - Font
extension Int {
    public var font: UIFont {
        return UIFont.systemFont(ofSize: self.cf)
    }
    
    public var boldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: self.cf)
    }
    
    public var italicFont: UIFont {
        return UIFont.italicSystemFont(ofSize: self.cf)
    }
    
    public var mediumFont: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: self.cf, weight: UIFont.Weight.medium)
        } else {
            return self.font
        }
    }
    
    public var semiboldFont: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: self.cf, weight: UIFont.Weight.semibold)
        } else {
            return self.font
        }
    }
    
    public var lightFont: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: self.cf, weight: UIFont.Weight.light)
        } else {
            return self.font
        }
    }
}
