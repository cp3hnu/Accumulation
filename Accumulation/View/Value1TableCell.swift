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
        public static var titleColor = UIColor.label
        public static var detailColor = UIColor.secondaryLabel
        public static var indicatorColor = UIColor.tertiaryLabel
        public static var indicatorImageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        public static var indicatorImage = UIImage(systemName: "chevron.right", withConfiguration: indicatorImageConfig)
        public static var backgroundColor = UIColor.secondarySystemGroupedBackground
    }

    static let reuseIdentifier = "Value1TableCell"
    static let rowHeight: CGFloat = 60
    
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let detailLabel = UILabel().font(Style.detailFont).textColor(Style.detailColor)
    public let indicator = UIImageView()
    public let seperator = UIView.seperator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Style.backgroundColor
        indicator.image = Style.indicatorImage
        indicator.tintColor = Style.indicatorColor
        
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
        asv(titleLabel, detailLabel, indicator, seperator)
        alignHorizontally(|-15-titleLabel.centerVertically()-(>=8)-detailLabel-8-indicator-15-|)
        |-15-seperator.height(0.5).bottom(0)|
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
