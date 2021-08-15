//
//  SwitchFormView.swift
//  Cards
//
//  Created by CP3 on 2017/12/7.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking
import RxSwift
import RxCocoa

public final class SwitchFormView: UIView {
    public struct Style {
        public static var font = 16.font
        public static var textColor = UIColor.compLabel
        public static var backgroundColor = UIColor.compTertiarySystemBackground
    }
    
    public let titleLabel = UILabel().font(Style.font).textColor(Style.textColor)
    public let switchCtrl = UISwitch()
    public let separator = UIView.separator()
    public var isOn: Bool {
        return switchCtrl.isOn
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        backgroundColor = Style.backgroundColor
        
        titleLabel.text = title
        asv(titleLabel, switchCtrl, separator)
        
        |-15-titleLabel.centerVertically()--(>=8)--switchCtrl.centerVertically()--15-|
        |-15-separator|.bottom(0).height(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}

// MARK: - RxSwift
extension Reactive where Base: SwitchFormView {
    public var isOn: ControlProperty<Bool> {
        return self.base.switchCtrl.rx.isOn
    }
    
    public var value: ControlProperty<Bool> {
        return self.base.switchCtrl.rx.value
    }
}

