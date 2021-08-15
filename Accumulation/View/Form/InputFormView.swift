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
    public let titleLabel = UILabel().fontSize(14).textColor(UIColor.Text.strong)
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

    public init(title: String, placeholder: String? = nil, offset: CGFloat? = nil, required: Bool = false) {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        textField.font = UIFont.contentFont
        textField.textColor = UIColor.Text.strong
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
    @discardableResult
    func addRightButton(title: String, target: AnyObject?, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.contentFont
        button.setTitleColor(UIColor.mainColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setTitleColor(UIColor.buttonTextColor.alpha(0.15), for: .disabled)
        button.addTarget(target, action: action, for: .touchUpInside)
        addRightButton(button)
        
        return button
    }
    
    @discardableResult
    func addRightButton(image: UIImage, target: AnyObject?, action: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        addRightButton(button)
        
        return button
    }
    
    @discardableResult
    func addRightButton(title: String, action: @escaping TapAction) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.contentFont
        button.setTitleColor(UIColor.mainColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setTitleColor(UIColor.buttonTextColor.alpha(0.15), for: .disabled)
        button.tap(action)
        addRightButton(button)
        
        return button
    }
    
    @discardableResult
    func addRightButton(image: UIImage, action: @escaping TapAction) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tap(action)
        addRightButton(button)
        
        return button
    }
    
    func addRightButton(_ button: UIButton) {
        rightView = button
        asv(button)
        button.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
        button.setContentHuggingPriority(UILayoutPriority.defaultLow + 1, for: .horizontal)
        
        textField.trailingConstraint?.isActive = false
        textField-15-button-0-|
    }
    
    func addRightView(_ rightView: UIView) {
        self.rightView = rightView
        asv(rightView)
        textField.trailingConstraint?.isActive = false
        textField-15-rightView-15-|
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
