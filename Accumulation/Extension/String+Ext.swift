//
//  String+Ext.swift
//  Cards
//
//  Created by CP3 on 17/6/7.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NSString
extension String {
    public var length: Int {
        return count
    }
    
    public func safeSubstring(from: Int) -> String {
        if from < 0 || from >= length {
            return ""
        }
        
        let fromIndex = index(startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    public func safeSubstring(range: NSRange) -> String {
        let from = range.location
        let len = range.length
        let to = from + len
        
        if from < 0 || len <= 0 || from >= length {
            return ""
        }
        
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex: String.Index
        if to < length {
            toIndex = index(startIndex, offsetBy: to)
        } else {
            toIndex = endIndex
        }
        
        return String(self[fromIndex..<toIndex])
    }
    
    public func safeSubstring(to: Int) -> String {
        if to < 0 {
            return ""
        }
        
        if to >= length {
            return self
        }
        
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[..<toIndex])
    }
}

// MARK: - Compare
extension String {
    func greaterThan(aStr: String, options: String.CompareOptions, range: Range<String.Index>? = nil, locale: Locale? = nil) -> Bool {
        return self.compare(aStr, options: options, range: range, locale: locale) == ComparisonResult.orderedDescending
    }
    
    func equalTo(aStr: String, options: String.CompareOptions, range: Range<String.Index>? = nil, locale: Locale? = nil) -> Bool {
        return self.compare(aStr, options: options, range: range, locale: locale) == ComparisonResult.orderedSame
    }
    
    func lessThan(aStr: String, options: String.CompareOptions, range: Range<String.Index>? = nil, locale: Locale? = nil) -> Bool {
        return self.compare(aStr, options: options, range: range, locale: locale) == ComparisonResult.orderedAscending
    }
}

// MARK: - Image
extension String {
    func image(size: CGSize, font: UIFont, bgColor: UIColor = UIColor.clear, textColor: UIColor = UIColor.white) -> UIImage {
        var attribute = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: font
        ]
        var textSize = self.size(withAttributes: attribute)
        let innerSize = CGSize(width: size.width - 8, height: size.height - 8)
        // 超出范围, 修改font size
        if textSize.width > innerSize.width {
            let fontSize = font.pointSize * innerSize.width /  textSize.width
            attribute[NSAttributedString.Key.font] = font.withSize(fontSize)
            textSize = self.size(withAttributes: attribute)
        }
        
        let point = CGPoint(x: (size.width - textSize.width)/2, y: (size.height - textSize.height)/2)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 2)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(bgColor.cgColor)
        context.fill(rect)
        self.draw(at: point, withAttributes: attribute)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - Others
extension String {
    var url: URL? {
        return URL(string: self)
    }
    
    func emptyTo(_ defaultValue: String) -> String {
        return !self.isEmpty ? self : defaultValue
    }
    
    func trimmingAllSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}

