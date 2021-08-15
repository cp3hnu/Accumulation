//
//  PlaceholderTextView.swift
//  hnup
//
//  Created by CP3 on 16/7/25.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking
import RxSwift

/// 带 placeholder 的 UITextView
public final class PlaceholderTextView: UITextView {
    
    private let disposeBag = DisposeBag()
    private let placeholderLabel = UILabel()
    
    public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    public var placeholderColor: UIColor = UIColor.gray.withAlphaComponent(0.7) {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
           placeholderLabel.font = placeholderFont
        }
    }
    
    public var placeholderOffset: UIOffset = UIOffset(horizontal: 5, vertical: 8) {
        didSet {
            placeholderLabel.leadingConstraint?.constant = placeholderOffset.horizontal + 5
            placeholderLabel.topConstraint?.constant = placeholderOffset.vertical
        }
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        asv(placeholderLabel)
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = placeholderFont
        placeholderLabel.leading(placeholderOffset.horizontal).top(placeholderOffset.vertical).trailing(>=0)
        
        rx.text.orEmpty.isNotEmpty
            .bind(to: placeholderLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
