//
//  UILabel.swift
//  Cards
//
//  Created by CP3 on 17/4/27.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @discardableResult
    public func fontSize(_ size: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: size)
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func fontStyle(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        self.adjustsFontForContentSizeCategory = true
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    public func text(_ str: String?) -> Self {
        self.text = str
        return self
    }
    
    @discardableResult
    public func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult
    public func lines(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
    
    @discardableResult
    public func alignLeft() -> Self {
        return align(.left)
    }
    
    @discardableResult
    public func alignCenter() -> Self {
        return align(.center)
    }
    
    @discardableResult
    public func alignRight() -> Self {
        return align(.right)
    }
    
    @discardableResult
    public func fitWidth() -> Self {
        self.adjustsFontSizeToFitWidth = true
        return self
    }
    
    private func align(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
}
