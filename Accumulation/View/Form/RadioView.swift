//
//  RadioView.swift
//  hnup
//
//  Created by CP3 on 16/11/25.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking

public final class RadioView: UIView {
    public var selectedIndex: Int {
        get {
            return _selectedIndex
        }
        
        set {
            if let button = viewWithTag(kBaseTag + newValue) as? UIButton {
                clearSelected()
                button.isSelected = true
                _selectedIndex = newValue
            }
        }
    }
    public var selectedAt: ((Int) -> Void)?
    
    private let kBaseTag = 100
    private var options: [String]
    private var _selectedIndex = 0
    
    public init(options: [String]) {
        self.options = options
        super.init(frame: CGRect.zero)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        var preButton: UIButton!
        for (index, item) in options.enumerated() {
            let button = UIButton()
            button.setImage(UIImage.bundleImage("radio-unselect"), for: .normal)
            button.setImage(UIImage.bundleImage("radio-selected"), for: .selected)
            button.setTitle(item, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.contentFont
            button.adjustsImageWhenHighlighted = false
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = kBaseTag + index
            button.addTarget(self, action: #selector(RadioView.buttonClicked), for: UIControl.Event.touchUpInside)
            addSubview(button)
            
            button.fillVertically()
            if index == 0 {
                button.isSelected = true
                button.leading(0)
            } else {
                preButton-15-button
            }
            
            preButton = button
        }
    }
    
    @objc private func buttonClicked(button: UIButton) {
        guard !button.isSelected else { return }
        
        clearSelected()
        button.isSelected = true
        _selectedIndex = button.tag - kBaseTag
        selectedAt?(_selectedIndex)
    }
    
    func clearSelected() {
        subviews.forEach {
            ($0 as? UIButton)?.isSelected = false
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}
