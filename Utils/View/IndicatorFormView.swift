//
//  IndicatorFormView.swift
//  hnup
//
//  Created by CP3 on 16/5/11.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking

enum IndicatorFormStyle {
    case `default`
    case valueAlignLeft(offset: CGFloat)
    case image(imageSize: CGFloat, imageSpace: CGFloat)
    case imageSubtitle(imageSize: CGFloat, imageSpace: CGFloat)
}

final class IndicatorFormView: UIView {
    struct Style {
        static var textFont = 16.font
        static var detailTextFont = 16.font
        static var placeholderFont = 16.font
        static var textColor = 0x333333.hexColor
        static var detailTextColor = 0x333333.hexColor
        static var placeholderColor = UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.22)
        static var indicatorImage = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: UIImage.SymbolWeight.regular))
        static var indicatorTintColor = 0x333333.hexColor
    }
    
    var tap: (() -> Void)?
    
    let textLabel = UILabel().font(Style.textFont).textColor(Style.textColor)
    let detailTextLabel = UILabel().font(Style.detailTextFont).textColor(Style.detailTextColor)
    let placeholderLabel = UILabel().font(Style.placeholderFont).textColor(Style.placeholderColor)
    let imageView = UIImageView()
    let seperator = UIView.seperator()
    let indicator = UIImageView(image: Style.indicatorImage)
    let style: IndicatorFormStyle
    
    // In default and valueAlignLeft style
    var value: String? {
        get {
            return detailTextLabel.text
        }
        set {
            detailTextLabel.text = newValue
            placeholderLabel.isHidden = newValue != nil
        }
    }
    
    // In imageSubtitle style
    var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    
    // In imageSubtitle style
    var detailText: String? {
        get {
            return detailTextLabel.text
        }
        set {
            detailTextLabel.text = newValue
        }
    }
    
    // In image or imageSubtitle style
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    // In default and valueAlignLeft style
    convenience init(title: String, placeholder: String? = nil, offset: CGFloat? = nil, value: String? = nil) {
        let style: IndicatorFormStyle = offset != nil ? .valueAlignLeft(offset: offset!) : .default
        self.init(style: style)
        
        textLabel.text = title
        detailTextLabel.text = value
        placeholderLabel.text = placeholder
        placeholderLabel.isHidden = value != nil
    }

    init(style: IndicatorFormStyle) {
        self.style = style
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        indicator.tintColor = Style.indicatorTintColor
        
        asv(
            imageView,
            textLabel,
            detailTextLabel,
            placeholderLabel,
            indicator,
            seperator
        )
        
        switch style {
        case .default:
            setConstaintsInDefaultStyle()
        case .valueAlignLeft(let offset):
            setConstaintsInValueAlignLeftStyle(offset: offset)
        case .image(let size, let space):
            setConstaintsInImageStyle(size: size, space: space)
        case .imageSubtitle(let size, let space):
            setConstaintsInImageSubtitleStyle(size: size, space: space)
        }
        
        //indicator.width(8).height(13)
        |-15-seperator.bottom(0).height(0.5)-0-|
        addTapAction { [unowned self] in
            self.tap?()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        var height: CGFloat = 44
        switch style {
        case .default, .valueAlignLeft:
            height = 44
        case .image(let size, let space):
            height = size + 2 * space
        case .imageSubtitle(let size, let space):
            height = size + 2 * space
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}

private extension IndicatorFormView {
    func setConstaintsInDefaultStyle() {
        imageView.isHidden = true
        detailTextLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh - 1, for: .horizontal)
        alignHorizontally(|-15-textLabel-(>=8)-detailTextLabel-15-indicator.centerVertically()-15-|)
        alignTrailings(detailTextLabel, placeholderLabel.centerVertically())
    }
    
    func setConstaintsInValueAlignLeftStyle(offset: CGFloat) {
        imageView.isHidden = true
        detailTextLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh - 1, for: .horizontal)
        alignHorizontally(|-15--textLabel--""--detailTextLabel.leading(offset)--15--indicator.centerVertically()--15-|)
        
        alignLeadings(detailTextLabel, placeholderLabel.centerVertically())
    }
    
    func setConstaintsInImageStyle(size: CGFloat, space: CGFloat) {
        detailTextLabel.isHidden = true
        placeholderLabel.isHidden = true
        |-15-textLabel.centerVertically()-(>=8)-imageView.fillVertically(space).size(size)-15-indicator.centerVertically()-15-|
    }
    
    func setConstaintsInImageSubtitleStyle(size: CGFloat, space: CGFloat) {
        placeholderLabel.isHidden = true
        layout(
            textLabel,
            4,
            Bricking.centerY,
            4,
            detailTextLabel
        )
        |-15-imageView.fillVertically(space).size(size)-textLabel-15-indicator.centerVertically()-15-|
        alignHorizontalEnds(textLabel, detailTextLabel)
    }
}
