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
    func fontSize(_ size: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: size)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func text(_ str: String?) -> Self {
        self.text = str
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func lines(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
    
    @discardableResult
    func alignLeft() -> Self {
        return align(.left)
    }
    
    @discardableResult
    func alignCenter() -> Self {
        return align(.center)
    }
    
    @discardableResult
    func alignRight() -> Self {
        return align(.right)
    }
    
    @discardableResult
    func fitWidth() -> Self {
        self.adjustsFontSizeToFitWidth = true
        return self
    }
    
    fileprivate func align(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
}
