//
//  FormView.swift
//  hnup
//
//  Created by CP3 on 16/5/29.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking
import RxSwift
import RxCocoa

public final class InputFormView: UIView {
    public struct Style {
        public static var titleFont = 14.font
        public static var titleColor = UIColor.compLabel
        public static var backgroundColor = UIColor.compTertiarySystemBackground
        public static var textFont = 14.font
        public static var textColor = UIColor.compLabel
    }
    
    public let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor)
    public let textField = UITextField()
    public let separator = UIView.separator()
    public var rightView: UIView?
    
    public var value: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    public var keyboardType: UIKeyboardType {
        get {
            return textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    public var isEnabled: Bool {
        get {
            return textField.isEnabled
        }
        set {
            textField.isEnabled = newValue
        }
    }

    public init(title: String, placeholder: String? = nil, offset: CGFloat? = nil, required: Bool = false) {
        super.init(frame: CGRect.zero)
        backgroundColor = Style.backgroundColor
        
        textField.font = Style.textFont
        textField.textColor = Style.textColor
        textField.placeholder = placeholder
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        
        if required {
            titleLabel.attributedText = title.attributed().append(string: "*", attributes: [NSAttributedString.Key.foregroundColor: UIColor(244, 122, 99), NSAttributedString.Key.baselineOffset: -1])
        } else {
            titleLabel.text = title
        }
        
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultLow + 2, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 2, for: .horizontal)
        asv(titleLabel, textField, separator)
        |-15-separator|.bottom(0).height(0.5)
        |-15-titleLabel.centerVertically()
        textField.fillVertically()-15-|
        if let offset = offset {
            |-offset-textField
        } else {
            titleLabel-textField
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
    
    @discardableResult
    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
}

// MARK: - Right View or Button
public extension InputFormView {
    func addRightView(_ rightView: UIView, trailing: CGFloat = 15) {
        self.rightView = rightView
        asv(rightView)
        textField.trailingConstraint?.isActive = false
        textField-15-rightView-trailing-|
        
        rightView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
        rightView.setContentHuggingPriority(UILayoutPriority.defaultLow + 1, for: .horizontal)
    }
    
    func removeRightView() {
        if let rightView = self.rightView {
            rightView.removeFromSuperview()
            textField-15-|
        }
    }
}

// MARK: - UITextFieldDelegate
extension InputFormView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - RxSwift
extension Reactive where Base: InputFormView {
    public var value: ControlProperty<String?> {
        return self.base.textField.rx.text
    }
}
