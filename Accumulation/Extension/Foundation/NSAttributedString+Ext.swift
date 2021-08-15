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

// MARK: - NSAttributedString 级联
extension NSAttributedString {
    // 一般方法
    @discardableResult
    public func append(string: String, attributes attrs: [NSAttributedString.Key: Any]?) -> NSAttributedString {
        let appended = string.attributed(attributes: attrs)
        let maString = NSMutableAttributedString(attributedString: self)
        maString.append(appended)
        return maString
    }
    
    // 一般查找方法，然后添加特性
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
    
    // 只修改 颜色/字体
    @discardableResult
    public func append(string: String, color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return append(string: string, attributes: attributes)
    }
    
    // 查找，只修改 颜色/字体
    @discardableResult
    public func addAttribute(searchText text: String, color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return addAttribute(searchText: text, attributes: attributes)
    }
    
    // 给 Range 内的字符串添加特性
    @discardableResult
    public func addAttributes(_ attrs: [NSAttributedString.Key: Any] = [:], range: Range<String.Index>) -> NSAttributedString {
        let nsRange = self.string.nsRange(from: range)
        return addAttributes(attrs, nsRange: nsRange)
    }
    
    // 给 NSRange 内的字符串添加特性
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
    
    // 一般查找方法，然后添加特性
    public func attributed(searchText text: String, attributes attrs: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return attributed().addAttribute(searchText: text, attributes: attrs)
    }
    
    // 只修改 Paragraph style
    public func attributed(paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        return attributed(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // 只修改 lineSpacing
    public func attributed(lineSpacing: CGFloat) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        return attributed(paragraphStyle: style)
    }
    
    // 只修改 颜色/字体
    public func attributed(color: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = color
        attributes[NSAttributedString.Key.font] = font
        return attributed(attributes: attributes)
    }
    
    // 查找方法，只修改 颜色/字体
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

// 计算NSAttributedString占用的高度
// NSAttributedString要先设置字体大小等影响高度属性
extension NSAttributedString {
    public func height(boundWidth: CGFloat) -> CGFloat {
        return boundingRect(with: CGSize(width: boundWidth, height: 0), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size.height
    }
}
