//
//  VerticalButton.swift
//  Cards
//
//  Created by CP3 on 2018/4/12.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit
import Bricking

public final class VerticalButton: UIButton {
    public let imgView = UIImageView()
    public let label = UILabel()
    
    public var textColor: UIColor = UIColor.Text.strong {
        didSet {
            label.textColor = textColor
        }
    }
    
    public var textFont: UIFont = UIFont.contentFont {
        didSet {
            label.font = textFont
        }
    }
    
    public init(image: UIImage?, title: String?, vSpace: CGFloat, vInset: CGFloat) {
        super.init(frame: CGRect.zero)
        
        imgView.image = image
        label.textColor = textColor
        label.font = textFont
        label.text = title
        
        asv(imgView, label)
        layout(
            vInset,
            imgView.centerHorizontally(),
            vSpace,
            label.centerHorizontally(),
            vInset
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
