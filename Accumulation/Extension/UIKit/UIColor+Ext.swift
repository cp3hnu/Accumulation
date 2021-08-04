//
//  UIColor+Ext.swift
//  Cards
//
//  Created by CP3 on 17/5/3.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit

// MARK: - Init
extension UIColor {
    public convenience init(hexColor: String) {
        var hexString = hexColor
        if hexColor.hasPrefix("#") {
            hexString = String(hexColor.dropFirst())
        }
        
        #if DEBUG
            let regExStr = "^[0-9a-fA-F]{6}$"
            let regEx = try! NSRegularExpression(pattern: regExStr, options: NSRegularExpression.Options(rawValue: 0))
            let range = NSRange(hexString.startIndex..., in: hexString)
            let firstMatch = regEx.firstMatch(in: hexString, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: range)
            if firstMatch == nil {
                print("The format of hex string is Wrong. The correct format is RRGGBB(such as \"FF0000\" for red color)")
            }
        #endif
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        self.init(rgbHex: Int(rgbValue))
    }
    
    public convenience init(redInt: Int, greenInt: Int, blueInt: Int) {
        self.init(red: CGFloat(redInt)/255.0,
                  green: CGFloat(greenInt)/255.0,
                  blue: CGFloat(blueInt)/255.0,
                  alpha: 1.0)
    }
    
    public convenience init(_ redInt: Int, _ greenInt: Int, _ blueInt: Int) {
        self.init(red: CGFloat(redInt)/255.0,
                  green: CGFloat(greenInt)/255.0,
                  blue: CGFloat(blueInt)/255.0,
                  alpha: 1.0)
    }
    
    public convenience init(rgbHex: Int) {
         self.init(redInt: (rgbHex & 0xFF0000) >> 16,
                   greenInt: (rgbHex & 0x00FF00) >> 8,
                   blueInt: rgbHex & 0x0000FF)
    }
    
    /**
     Initializes.
     
     - parameter grayscaleValue: The RGB grayscale value.
     */
    public convenience init(grayscaleValue: Int) {
        self.init(redInt: grayscaleValue,
                  greenInt: grayscaleValue,
                  blueInt: grayscaleValue)
    }
}

// MARK: - Other
extension UIColor {
    public var image: UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public func image(size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public func alpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
}

// MARK: - String
extension String {
    public var hexColor: UIColor {
        return UIColor(hexColor: self)
    }
}

// MARK: - Int
extension Int {
    public var grayColor: UIColor {
        return UIColor(grayscaleValue: self)
    }
    
    public var hexColor: UIColor {
        return UIColor(rgbHex: self)
    }
}
