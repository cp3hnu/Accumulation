//
//  DefaultTableCell.swift
//  Cards
//
//  Created by CP3 on 2017/8/15.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking

public final class DefaultTableCell: UITableViewCell {
    public struct Style {
        public static var titleFont = 16.font
        public static var titleColor =  UIColor.compLabel
        public static var indicatorColor = UIColor.compTertiaryLabel
        @available(iOS 13.0, *)
        public static var indicatorImageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        @available(iOS 13.0, *)
        public static var indicatorImage = UIImage(systemName: "chevron.right", withConfiguration: indicatorImageConfig)
        public static var compIndicatorImage = #imageLiteral(resourceName: "cell-indicator")
        public static var backgroundColor = UIColor.compSecondarySystemGroupedBackground
    }
    
    public static let defaultReuseId = "\(DefaultTableCell.self)"
    public static let withImageReuseId = "DefaultTableCell_With_Image"
    public static let rowHeight: CGFloat = 60
    
    public let displayImgView = UIImageView()
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let indicator = UIImageView()
    public let separator = UIView.separator()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Style.backgroundColor
        if #available(iOS 13.0, *) {
            indicator.image = Style.indicatorImage
        } else {
            indicator.image = Style.compIndicatorImage
        }
        indicator.tintColor = Style.indicatorColor
        
        asv(
            displayImgView,
            titleLabel,
            indicator,
            separator
        )
        
        if reuseIdentifier == DefaultTableCell.defaultReuseId {
            displayImgView.isHidden = true
            |-15-titleLabel.centerVertically()--(>=10)-indicator-15-|
        } else {
           |-15-displayImgView.size(30)-10-titleLabel.centerVertically()-(>=10)-indicator-15-|
        }
        alignHorizontally(titleLabel, displayImgView, indicator)
        |-15-separator.height(0.5).bottom(0)-0-|
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
