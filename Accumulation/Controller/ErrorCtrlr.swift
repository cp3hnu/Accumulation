//
//  ErrorCtrlr.swift
//  hnup
//
//  Created by Jian Hu on 16/5/22.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking

public enum EmptyError {
    case noData
    case error(Error)
    case appError(String)
    case custom(UIView, UIEdgeInsets)
    
    var desc: String {
        switch self {
        case .noData:
            return "暂无数据"
        case .error(let error):
            return error.localizedDescription
        case .appError(let message):
            return message
        case .custom(_, _):
            return ""
        }
    }
    
    var image: UIImage? {
        switch self {
        case .noData:
            return #imageLiteral(resourceName: "error-no-data")
        case .error(_), .appError(_):
            return #imageLiteral(resourceName: "error-no-network")
        case .custom(_, _):
            return nil
        }
    }
}

/// 显示空数据或者网络请求错误的 UIViewController
final class ErrorCtrlr: UIViewController {
    
    private let error: EmptyError
    private let onRetry: (() -> Void)?
    
    init(error: EmptyError, onRetry:(() -> Void)? = nil) {
        self.error = error
        self.onRetry = onRetry
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        if case let EmptyError.custom(customView, inset) = error {
            view.asv(customView)
            customView.top(inset.top).bottom(inset.bottom).leading(inset.left).trailing(inset.right)
        } else {
            setupView()
        }
    }
    
    private func setupView() {
        let imageView = UIImageView()
        imageView.image = error.image
        
        let descLabel = UILabel().font(UIFont.contentFont).lines(0).textColor(UIColor.Text.light).alignCenter()
        descLabel.text = error.desc
        
        let retryBtn = UIButton.universalButton(title: "点击重试")
        retryBtn.tap { [weak self] in
            self?.onRetry?()
        }
        
        let centerView = UIView()
        centerView.asv(imageView, descLabel, retryBtn)
        
        view.asv(centerView)
        |centerView|.centerVertically()
        
        centerView.layout(
            0,
            imageView.centerHorizontally(),
            36,
            |-20-descLabel-20-|,
            50,
            |-20-retryBtn-20-| ~ 44,
            0
        )
        
        retryBtn.isBottomSpaceReserved = true
        retryBtn.collapseVertically = onRetry == nil ? true : false
    }
}
