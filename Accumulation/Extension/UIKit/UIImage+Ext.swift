//
//  UIImage+Ext.swift
//  Cards
//
//  Created by CP3 on 17/5/4.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit

extension UIImage {
    public enum CircleMode {
        case scaleToFill
        case scaleAspectFit
    }
    
    /// 圆形带边框图片
    public func circleImage(mode: CircleMode = .scaleToFill, borderSize: CGFloat = 0, borderColor: UIColor = UIColor.white) -> UIImage {
        let width = size.width
        let height = size.height
        let innerSquare: CGFloat
        if mode == .scaleToFill {
            innerSquare = min(width, height)
        } else {
            innerSquare = max(width, height)
        }
        
        let outerSquare = innerSquare + 2 * borderSize
        let outerRadius = outerSquare/2 - borderSize/2
        let innerRadius = innerSquare/2
        let center = CGPoint(x: outerSquare/2, y: outerSquare/2)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: outerSquare, height: outerSquare), false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        
        if (borderSize > 0) {
            context.addArc(center: center, radius: outerRadius, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true)
            context.setLineWidth(borderSize)
            context.setStrokeColor(borderColor.cgColor)
            context.closePath()
            context.strokePath()
        }
        
        context.addArc(center: center, radius: innerRadius, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true)
        context.closePath()
        context.clip()
        
        let imageWidth: CGFloat
        let imageHeight: CGFloat
        if mode == .scaleToFill {
            imageWidth = innerSquare
            imageHeight = innerSquare
        } else {
            imageWidth = width
            imageHeight = height
        }
        let imageOriginX = (outerSquare - imageWidth)/2
        let imageOriginY = (outerSquare - imageHeight)/2
        
        draw(in: CGRect(x: imageOriginX, y: imageOriginY, width: imageWidth, height: imageHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 改变图片的颜色
    public func changeColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        context.clip(to: rect, mask: cgImage!)
        color.setFill()
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 等比缩放
    public func resizedToAspectFitSize(_ newSize: CGSize, newScale: CGFloat = 0.0) -> UIImage {
        let widthRatio = newSize.width / size.width
        let heightRatio = newSize.height / size.height
        let scaledRatio = min(widthRatio, heightRatio)
        let scaledTransform = CGAffineTransform(scaleX: scaledRatio, y: scaledRatio)
        let scaledSize = size.applying(scaledTransform)
        let drawRect = CGRect(origin: CGPoint.zero, size: scaledSize)
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, newScale)
        draw(in: drawRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 缩放
    public func resizedToFillSize(_ newSize: CGSize, newScale: CGFloat = 0.0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, newScale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 混合图片
    public func addImage(_ image: UIImage, imageSize: CGSize? = nil) -> UIImage {
        var addImageSize = image.size
        if let imageSize = imageSize {
            addImageSize = imageSize
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        image.draw(in: CGRect(x: (size.width - addImageSize.width)/2, y: (size.height - addImageSize.height)/2, width: addImageSize.width, height: addImageSize.height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /// 混合图片
    public func addImage(_ image: UIImage, imageRect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        image.draw(in: imageRect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /// 移动图片
    public func moveToPosition(_ point: CGPoint) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(x: point.x, y: point.y, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
