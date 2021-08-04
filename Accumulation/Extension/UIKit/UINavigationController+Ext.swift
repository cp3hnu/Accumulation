//
//  UINavigationController.swift
//  Cards
//
//  Created by CP3 on 17/5/18.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Status Bar
extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
}

// MARK: - Pop Type & Page
public extension UINavigationController {
    /**
     返回到指定类名的ViewContoller
     - parameter types: 越上层的ViewContoller越要放在后面
     */
    @discardableResult
    func popTo(types: [UIViewController.Type], animated: Bool) -> UIViewController? {
        var controller: UIViewController?
        found: for vc in viewControllers.reversed() {
            for item in types {
                if type(of: vc) == item {
                    controller = vc
                    break found
                }
            }
        }
        
        if let vc = controller {
            popToViewController(vc, animated: animated)
            return controller
        } else {
            // 容错处理，万一没找到还能返回到root
            popToRootViewController(animated: animated)
            return viewControllers.first
        }
    }
    
    /**
     返回到倒数第几页
     - parameter lastPage: 倒数第几页, 当前页 lastPage = 0, 上一页 lastPage = 1, ...
     */
    @discardableResult
    func popTo(lastPage: Int, animated: Bool) -> UIViewController? {
        if viewControllers.count - 1 >= lastPage {
            let controller = viewControllers[viewControllers.count - lastPage - 1]
            popToViewController(controller, animated: animated)
            return controller
        } else {
            // 容错处理，万一没找到还能返回到root
            popToRootViewController(animated: animated)
            return viewControllers.first
        }
    }
}
