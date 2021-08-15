//
//  UIViewController+Ext.swift
//  Accumulation
//
//  Created by CP3 on 7/8/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

public struct SheetItem {
    public let title: String
    public let style: UIAlertAction.Style
    
    public init(title: String, style: UIAlertAction.Style = .default) {
        self.title = title
        self.style = style
    }
}

// 弹出简单的 Alert & Sheet
extension UIViewController {
    public func popupAlert(title: String?, message: String?, canCancel: Bool = true, cancelTitle: String = "取消", cancelAction: ((UIAlertAction) -> Void)? = nil, isDestructive: Bool = false, preferredTitle: String = "确定", preferredAction: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if canCancel {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
            alert.addAction(cancelAction)
        }
        
        let preferredAction = UIAlertAction(title: preferredTitle, style: isDestructive ? .destructive : .default, handler: preferredAction)
        alert.addAction(preferredAction)
        alert.preferredAction = preferredAction
        
        present(alert, animated: true, completion: nil)
    }
    
    public func popupSheet(title: String? = nil, message: String? = nil, cancelTitle: String = "取消", cancelAction: ((UIAlertAction) -> Void)? = nil, items: [SheetItem], itemAction: @escaping ((Int) -> Void)) {

        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        actionSheet.addAction(cancelAction)

        for (index, item) in items.enumerated() {
            let preferredAction = UIAlertAction(title: item.title, style: item.style) { _ in
                itemAction(index)
            }
            actionSheet.addAction(preferredAction)
        }

        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - AssociatedObject
extension UIViewController {
    private struct AssociatedKeys {
        static var isNavBarHiddenKey = "isNavBarHidden_key"
        static var navBarBgColorKey = "navBarBgColor_key"
        static var isEdgePopEnabledKey = "isEdgePopEnabled_key"
    }
    
    public var isNavBarHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isNavBarHiddenKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isNavBarHiddenKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public var navBarBgColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navBarBgColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarBgColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var isEdgePopEnabled: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isEdgePopEnabledKey) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isEdgePopEnabledKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

