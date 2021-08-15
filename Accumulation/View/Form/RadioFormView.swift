//
//  RadioFormView.swift
//  Cards
//
//  Created by CP3 on 2018/1/15.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit
import Bricking

public class RadioFormView: UIView {
    public struct Style {
        public static var titleFont = 16.font
        public static var titleColor = UIColor.compLabel
        public static var backgroundColor = UIColor.compTertiarySystemBackground
    }
    
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let separator = UIView.separator()
    public var radioView: RadioView!
    public var selectedAt: ((Int) -> Void)?
    
    public var selectedIndex: Int {
        get {
            return radioView.selectedIndex
        }
        
        set {
           radioView.selectedIndex = newValue
        }
    }
    
    /// valueLabel默认右对齐，valueOffset != nil时，valueLabel左对齐
    public init(title: String, options: [String], offset: CGFloat? = nil) {
        super.init(frame: CGRect.zero)
        backgroundColor = Style.backgroundColor
        
        titleLabel.text = title
        let radioView = RadioView(options: options)
        radioView.selectedAt = { [unowned self] index in
            self.selectedAt?(index)
        }
        
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultLow + 1, for: .horizontal)
        asv(titleLabel, radioView, separator)
        |-15-titleLabel.centerVertically()
        radioView.fillVertically(0)-15-|
        |-15-separator.bottom(0).height(0.5)|
        
        if let offsetWrapped = offset {
            radioView.leading(offsetWrapped)
        } else {
            titleLabel-(>=8)-radioView
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}
