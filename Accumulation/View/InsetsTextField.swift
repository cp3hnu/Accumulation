//
//  InsetsTextField.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/5/31.
//  Copyright © 2021 CP3. All rights reserved.
//

import UIKit

/// 带 insets 的 UITextField
public final class InsetsTextField: UITextField {

    private let insets: UIEdgeInsets
    public init(insets: UIEdgeInsets = UIEdgeInsets.zero) {
        self.insets = insets
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
