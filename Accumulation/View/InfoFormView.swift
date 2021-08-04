//
//  InfoFormView.swift
//  hnup
//
//  Created by CP3 on 16/5/30.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking

public final class InfoFormView: UIView {
    public struct Style {
        public static var titleFont = 16.font
        public static var valueFont = 16.font
        public static var titleColor = UIColor.compLabel
        public static var valueColor = UIColor.compLabel
        public static var backgroundColor = UIColor.compTertiarySystemBackground
    }
    
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let valueLabel = UILabel().font(Style.valueFont).textColor(Style.valueColor).lines(0)
    public let separator = UIView.separator()
    
    public var value: String? {
        get {
            return valueLabel.text
        }
        set {
            valueLabel.text = newValue
        }
    }
    
    /// valueLabel默认右对齐，valueOffset != nil时，valueLabel左对齐
    public init(title: String, value: String?, valueOffset: CGFloat? = nil) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = Style.backgroundColor
        
        titleLabel.text = title
        valueLabel.text = value
        valueLabel.alignLeft()
        
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultLow + 1, for: .horizontal)
        asv(titleLabel, valueLabel, separator)
        |-15-titleLabel.top(14)
        valueLabel.fillVertically(14).height(>=17)-15-|
        |-15-separator.bottom(0).height(0.5)-0-|
        
        if let offset = valueOffset {
            valueLabel.leading(offset)
        } else {
            titleLabel-(>=8)-valueLabel
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

