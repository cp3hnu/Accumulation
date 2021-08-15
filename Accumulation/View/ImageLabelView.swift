//
//  ImageLabelView.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/5/27.
//  Copyright © 2021 CP3. All rights reserved.
//

import UIKit
import Bricking

/// 带有图片和文字的 view，支持横排和竖排
public final class ImageLabelView: UIView {
    
    public enum Direction {
        case Horizontal(CGFloat, UIEdgeInsets)
        case Vertical(CGFloat, UIEdgeInsets)
    }
    
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    public var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }

    public let textLabel = UILabel().fontSize(14).textColor(0x333333.hexColor)
    public let imageView = UIImageView()
    
    public init(direction: Direction, imageSize: CGSize, image: UIImage?, text: String?) {
        super.init(frame: CGRect.zero)
        
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.image = image
        textLabel.text = text
        
        asv(imageView, textLabel)
        imageView.width(imageSize.width).height(imageSize.height)
        switch direction {
        case .Horizontal(let offset, let inset):
            self.layout(
                inset.top,
                |-inset.left-imageView-offset-textLabel-inset.right-|,
                inset.bottom
            )
        case .Vertical(let offset, let inset):
            textLabel.textAlignment = .center
            self.layout(
                inset.top,
                imageView.centerHorizontally(),
                offset,
                |-inset.left-textLabel-inset.right-|,
                inset.bottom
            )
            textLabel.laWidth >= imageView.laWidth
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(_ image: UIImage, size: CGSize = CGSize(width: 82, height: 82)) {
        imageView.image = image
        imageView.widthConstraint?.constant = size.width
        imageView.heightConstraint?.constant = size.height
    }
}
