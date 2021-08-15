//
//  SubtitleTableCell.swift
//  Cards
//
//  Created by CP3 on 2017/10/11.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking

public final class SubtitleTableCell: UITableViewCell {
    public struct Style {
        public static var titleFont = 16.font
        public static var titleColor =  UIColor.compLabel
        public static var subtitleFont = 14.font
        public static var subtitleColor =  UIColor.compLabel
        public static var indicatorColor = UIColor.compTertiaryLabel
        @available(iOS 13.0, *)
        public static var indicatorImageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        @available(iOS 13.0, *)
        public static var indicatorImage = UIImage(systemName: "chevron.right", withConfiguration: indicatorImageConfig)
        public static var compIndicatorImage = #imageLiteral(resourceName: "cell-indicator")
        public static var backgroundColor = UIColor.compSecondarySystemGroupedBackground
    }
    
    public static let reuseId = "\(SubtitleTableCell.self)"

    public let displayImgView = UIImageView()
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let subtitleLabel = UILabel().font(Style.subtitleFont).textColor(Style.subtitleColor)
    public let indicator = UIImageView()
    
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
            subtitleLabel,
            indicator
        )
        
        layout(
            15,
            titleLabel,
            4,
            subtitleLabel,
            15
        )
        
        |-15-displayImgView.size(30).centerVertically()-10-titleLabel-8-indicator-15-|
        alignHorizontalEnds(titleLabel, subtitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
