//
//  InsetLabel.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/7/29.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
import UIKit

/// 带 insets 的 UILabel
public final class InsetsLabel: UILabel {
    private let insets: UIEdgeInsets
    
    public init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += insets.left + insets.right
        size.height += insets.top + insets.bottom
        return size
    }
}
