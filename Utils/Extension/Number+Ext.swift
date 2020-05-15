//
//  Number+Ext.swift
//  Cards
//
//  Created by CP3 on 2018/1/17.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    var twoDecimalPlaces: String { String(format: "%.2f", self) }
    var cf: CGFloat { CGFloat(self) }
}

extension Int {
    var cf: CGFloat { CGFloat(self) }
    var f: Float { Float(self) }
    var d: Double { Double(self) }
}

extension Float {
    var cf: CGFloat { CGFloat(self) }
}

extension CGFloat {
    var d: Double { Double(self) }
    var f: Float { Float(self) }
    var i: Int {  Int(self) }
}

// MARK: - Font
extension Int {
    var font: UIFont {
        return UIFont.systemFont(ofSize: self.cf)
    }
    
    var boldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: self.cf)
    }
    
    var italicFont: UIFont {
        return UIFont.italicSystemFont(ofSize: self.cf)
    }
    
    var mediumFont: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: self.cf, weight: UIFont.Weight.medium)
        } else {
            return self.font
        }
    }
    
    var semiboldFont: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: self.cf, weight: UIFont.Weight.semibold)
        } else {
            return self.font
        }
    }
    
    var lightFont: UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: self.cf, weight: UIFont.Weight.light)
        } else {
            return self.font
        }
    }
}
