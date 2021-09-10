//
//  UIViewController+EmptyData.swift
//  Cards
//
//  Created by CP3 on 2017/10/28.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import UIKit
import Bricking

extension UIViewController {
    public func presentEmptyCtrlr(error: EmptyError = .noData, topInset: CGFloat = 0, bottomInset: CGFloat = 0, onRetry: (() -> Void)? = nil) {
        guard errorCtrlr == nil else { return }
        
        let errCtrlr = EmptyErrorCtrlr(error: error, onRetry: onRetry)
        addChild(errCtrlr)
        view.asv(errCtrlr.view)
        errCtrlr.view.fillHorizontally().top(topInset).bottom(bottomInset)
        errCtrlr.didMove(toParent: self)
    }
    
    public func presentEmptyCtrlr(containerView: UIView, error: EmptyError = .noData, topInset: CGFloat = 0, bottomInset: CGFloat = 0, onRetry: (() -> Void)? = nil) {
        guard errorCtrlr == nil else { return }
        
        let errCtrlr = EmptyErrorCtrlr(error: error, onRetry: onRetry)
        addChild(errCtrlr)
        containerView.asv(errCtrlr.view)
        errCtrlr.view.fillHorizontally().top(topInset).bottom(bottomInset)
        errCtrlr.didMove(toParent: self)
    }
    
    public func dissmissEmptyCtrlr() {
        guard let errorCtrlr = errorCtrlr else { return }
        
        errorCtrlr.willMove(toParent: nil)
        errorCtrlr.view.removeFromSuperview()
        errorCtrlr.removeFromParent()
    }
    
    public func presentEmptyCtrlr(tableView: UITableView, error: EmptyError = .noData, onRetry: (() -> Void)? = nil) {
        guard errorCtrlr == nil else { return }
        
        let errCtrlr = EmptyErrorCtrlr(error: error, onRetry: onRetry)
        
        tableView.isScrollEnabled = false
        addChild(errCtrlr)
        tableView.backgroundView = errCtrlr.view
        errCtrlr.didMove(toParent: self)
    }
    
    public func dissmissEmptyCtrlr(tableView: UITableView) {
        guard let errorCtrlr = errorCtrlr else { return }
        tableView.backgroundView = nil
        tableView.isScrollEnabled = true
        
        errorCtrlr.willMove(toParent: nil)
        errorCtrlr.view.removeFromSuperview()
        errorCtrlr.removeFromParent()
    }
    
    public func presentOrDismissEmptyCtrlr(tableView: UITableView, isEmpty: Bool, error: EmptyError = .noData, onRetry: (() -> Void)? = nil) {
        if isEmpty {
            presentEmptyCtrlr(tableView: tableView, error: error, onRetry: onRetry)
        } else {
            dissmissEmptyCtrlr(tableView: tableView)
        }
    }
    
    private var errorCtrlr: EmptyErrorCtrlr? {
        get {
            for vc in children {
                if let ctrlr = vc as? EmptyErrorCtrlr {
                    return ctrlr
                }
            }
            return nil
        }
    }
}
