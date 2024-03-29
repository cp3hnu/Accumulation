//
//  UIButton+Style.swift
//  WordCard
//
//  Created by CP3 on 5/14/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Style
extension UIButton {
    /// 通用的按钮样式
    public static func universalButton(title: String = "确定") -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = 16.font
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.setTitleColor(0xffffff.hexColor, for: .normal)
        button.setTitleColor(0xffffff.hexColor, for: .disabled)
        button.setBackgroundColor(UIColor.mainColor, for: .normal)
        button.setBackgroundColor(0x516FDF.hexColor.alpha(0.3), for: .disabled)
        return button
    }
    
    /// 自定义通用颜色按钮样式
    public static func universalButton(title: String, bgColor: UIColor, titleColor: UIColor = UIColor.white, font: UIFont = 16.font, image: UIImage? = nil, titleGap: CGFloat = 0) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleGap, bottom: 0, right: -titleGap)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.setBackgroundColor(bgColor, for: .normal)
        button.tintColor = titleColor
        return button
    }
    
    /// 取消按钮样式，白色的背景，蓝色的文字，蓝色的边框
    public static func cancelButton(title: String = "取消") -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = 16.font
        button.layer.cornerRadius = 22
        button.setTitleColor(UIColor.mainColor, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.backgroundColor = UIColor.white
        return button
    }
    
    /// 类似于链接那种Button
    public static func linkButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.urlLinkColor, for: .normal)
        button.titleLabel?.font = UIFont.contentFont
        button.setTitle(title, for: .normal)
        return button
    }
}
