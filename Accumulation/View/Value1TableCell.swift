//
//  Value1TableCell.swift
//  GitMyStar
//
//  Created by CP3 on 17/4/27.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking

public final class Value1TableCell: UITableViewCell {
    public struct Style {
        public static var titleFont = 16.font
        public static var detailFont = 16.font
        public static var titleColor =  UIColor.compLabel
        public static var detailColor = UIColor.compSecondaryLabel
        public static var indicatorColor = UIColor.compTertiaryLabel
        @available(iOS 13.0, *)
        public static var indicatorImageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        @available(iOS 13.0, *)
        public static var indicatorImage = UIImage(systemName: "chevron.right", withConfiguration: indicatorImageConfig)
        public static var compIndicatorImage = #imageLiteral(resourceName: "cell-indicator")
        public static var backgroundColor = UIColor.compSecondarySystemGroupedBackground
    }
    
    public static let reuseId = "Value1TableCell"
    public static let rowHeight: CGFloat = 60
    
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let detailLabel = UILabel().font(Style.detailFont).textColor(Style.detailColor)
    public let indicator = UIImageView()
    public let separator = UIView.separator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Style.backgroundColor
        if #available(iOS 13.0, *) {
            indicator.image = Style.indicatorImage
        } else {
            indicator.image = Style.compIndicatorImage
        }
        indicator.tintColor = Style.indicatorColor
        
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
        asv(
            titleLabel,
            detailLabel,
            indicator,
            separator
        )
        alignHorizontally(|-15-titleLabel.centerVertically()-(>=8)-detailLabel-8-indicator-15-|)
        |-15-separator.height(0.5).bottom(0)|
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
