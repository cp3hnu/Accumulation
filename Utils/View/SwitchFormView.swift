//
//  SwitchFormView.swift
//  Cards
//
//  Created by CP3 on 2017/12/7.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking

final class SwitchFormView: UIView {
    struct Style {
        static var font = 16.font
        static var textColor = 0x333333.hexColor
        static var backgroundColor = UIColor.white
    }
    
    let titleLabel = UILabel().font(Style.font).textColor(Style.textColor)
    let switchCtrl = UISwitch()
    let seperator = UIView.seperator()
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        backgroundColor = Style.backgroundColor
        
        titleLabel.text = title
        asv(titleLabel, switchCtrl, seperator)
        
        |-15-titleLabel.centerVertically()--(>=8)--switchCtrl.centerVertically()--15-|
        |-15-seperator|.bottom(0).height(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}
