//
//  IndicatorFormView.swift
//  hnup
//
//  Created by CP3 on 16/5/11.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking
import RxSwift
import RxCocoa

public enum IndicatorFormStyle {
    /// 默认样式，左边 `tittle`，右边 `value`，`value` 右对齐
    case `default`
    /// 左边 `tittle`，然后接着 `value`，`value` 左对齐
    case valueAlignLeft(offset: CGFloat)
    /// 左边 `tittle`，右边 `image`，使用场景 `设置头像`
    case image(imageSize: CGFloat, imageSpace: CGFloat)
    /// 左边 `image`和然后接着 `text` 和 `detailText`
    case imageSubtitle(imageSize: CGFloat, imageSpace: CGFloat)
}

public final class IndicatorFormView: UIView {
    public struct Style {
        public static var textFont = 16.font
        public static var detailTextFont = 16.font
        public static var placeholderFont = 16.font
        public static var textColor = UIColor.compLabel
        public static var detailTextColor = UIColor.compLabel
        public static var placeholderColor = UIColor.compPlaceholderText
        @available(iOS 13.0, *)
        public static var indicatorImageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        @available(iOS 13.0, *)
        public static var indicatorImage = UIImage(systemName: "chevron.right", withConfiguration: indicatorImageConfig)
        public static var indicatorColor = UIColor.compLabel
        public static var backgroundColor = UIColor.compTertiarySystemBackground
    }
    
    public var tap: (() -> Void)?
    public let textLabel = UILabel().font(Style.textFont).textColor(Style.textColor)
    public let detailTextLabel = UILabel().font(Style.detailTextFont).textColor(Style.detailTextColor)
    public let placeholderLabel = UILabel().font(Style.placeholderFont).textColor(Style.placeholderColor)
    public let imageView = UIImageView()
    public let separator = UIView.separator()
    public let indicator = UIImageView()
    private let style: IndicatorFormStyle
    fileprivate let valueSubject = BehaviorSubject<String?>(value: nil)
    
    // In default and valueAlignLeft style
    public var value: String? {
        get {
            return detailTextLabel.text
        }
        set {
            detailTextLabel.text = newValue
            placeholderLabel.isHidden = newValue != nil
            valueSubject.onNext(newValue)
        }
    }
    
    // In imageSubtitle style
    public var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    
    // In imageSubtitle style
    public var detailText: String? {
        get {
            return detailTextLabel.text
        }
        set {
            detailTextLabel.text = newValue
        }
    }
    
    // In image or imageSubtitle style
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    // MARK: - Init
    public init(style: IndicatorFormStyle) {
        self.style = style
        super.init(frame: CGRect.zero)
        
        backgroundColor = Style.backgroundColor
        indicator.tintColor = Style.indicatorColor
        if #available(iOS 13.0, *) {
            indicator.image = Style.indicatorImage
        } else {
            indicator.image = #imageLiteral(resourceName: "cell-indicator")
        }
        
        asv(
            imageView,
            textLabel,
            detailTextLabel,
            placeholderLabel,
            indicator,
            separator
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
        |-15-separator.bottom(0).height(0.5)-0-|
        addTapAction { [unowned self] in
            self.tap?()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // In default and valueAlignLeft style
    public convenience init(title: String, placeholder: String? = nil, offset: CGFloat? = nil, value: String? = nil) {
        let style: IndicatorFormStyle = offset != nil ? .valueAlignLeft(offset: offset!) : .default
        self.init(style: style)
        
        textLabel.text = title
        detailTextLabel.text = value
        placeholderLabel.text = placeholder
        placeholderLabel.isHidden = value != nil
    }
    
    public override var intrinsicContentSize: CGSize {
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

// MARK: - Constraint
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

// MARK: - RxSwift
extension Reactive where Base: IndicatorFormView {
    public var value: ControlProperty<String?> {
        let observable = self.base.valueSubject.asObservable()
        let binder = Binder<String?>(self.base) { formView, value in
            formView.value = value
        }
        return ControlProperty<String?>.init(values: observable, valueSink: binder)
    }
}
