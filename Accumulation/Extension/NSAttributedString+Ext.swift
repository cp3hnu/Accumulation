//
//  NSAttributedString+Ext.swift
//  Cards
//
//  Created by CP3 on 2017/8/13.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    // NSAttributedString 转 NSMutableAttributedString
    public var mutableAttributedString: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
}

extension NSAttributedString {
    // 一般方法
    @discardableResult
    public func append(string: String, attributes attrs: [NSAttributedString.Key: Any]?) -> NSAttributedString {
        let appended = string.attributed(attributes: attrs)
        let maString = NSMutableAttributedString(attributedString: self)
        maString.append(appended)
        return maString
    }
    
    // 查找，然后添加特性
    @discardableResult
    public func addAttribute(searchText text: String, attributes attrs: [NSAttributedString.Key: Any]) -> NSAttributedString {
        guard let range = self.string.range(of: text) else {
            return self
        }
        
        let nsRange = self.string.nsRange(from: range)
        let maString = NSMutableAttributedString(attributedString: self)
        maString.addAttributes(attrs, range: nsRange)
        return maString
    }
    
    // 根据使用情况一般是修改颜色和字体大小
    @discardableResult
    public func append(string: String, color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return append(string: string, attributes: attributes)
    }
    
    // 根据使用情况一般是修改颜色和字体大小
    @discardableResult
    public func addAttribute(searchText text: String, color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return addAttribute(searchText: text, attributes: attributes)
    }
    
    // 给 range 内的字符串添加特性
    @discardableResult
    public func addAttributes(_ attrs: [NSAttributedString.Key: Any] = [:], range: Range<String.Index>) -> NSAttributedString {
        let nsRange = self.string.nsRange(from: range)
        return addAttributes(attrs, nsRange: nsRange)
    }
    
    // 给 range 内的字符串添加特性
    @discardableResult
    public func addAttributes(_ attrs: [NSAttributedString.Key: Any] = [:], nsRange: NSRange) -> NSAttributedString {
        let maString = NSMutableAttributedString(attributedString: self)
        maString.addAttributes(attrs, range: nsRange)
        return maString
    }
}

// MARK: - String 转 NSAttributedString
extension String {
    // 一般方法
    public func attributed(attributes attrs: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attrs)
    }
    
    // 查找，然后添加特性
    public func attributed(searchText text: String, attributes attrs: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return attributed().addAttribute(searchText: text, attributes: attrs)
    }
    
    // 根据使用情况一般是修改 Paragraph style
    public func attributed(paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return attributed(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // 根据使用情况一般是修改颜色和字体大小
    public func attributed(color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return attributed(attributes: attributes)
    }
    
    // 根据使用情况一般是修改颜色和字体大小
    public func attributed(searchText text: String, color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return attributed(searchText: text, attributes: attributes)
    }
    
    // 添加图片
    public func append(image: UIImage, bound: CGRect, color: UIColor? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        if let color = color {
            attachment.image = image.changeColor(color)
        } else {
            attachment.image = image
        }
        
        attachment.bounds = bound
        let attributedText = self.attributed().mutableAttributedString
        attributedText.append(NSAttributedString(attachment: attachment))
        return attributedText
    }
}

// MARK: - UIImage 转 NSAttributedString
extension UIImage {
    public func attributedString(bounds: CGRect? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = self
        if let unwBounds = bounds {
           attachment.bounds = unwBounds
        }
        return NSAttributedString(attachment: attachment)
    }
}

// MARK: - Range 和 NSRange 相互转化
extension String {
    public func range(from: NSRange) -> Range<String.Index>? {
        return Range<String.Index>(from, in: self)
    }
    
    public func nsRange(from: Range<String.Index>) -> NSRange {
        return NSRange(from, in: self)
    }
}
