//
//  EmptyErrorCtrlr.swift
//  hnup
//
//  Created by CP3 on 16/5/22.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking

public enum EmptyError {
    case noData
    case error(Error)
    case appError(String)
    case customView(UIView, UIEdgeInsets)
    case custom(UIImage?, String, String)
    
    var image: UIImage? {
        switch self {
        case .noData:
            return UIImage.bundleImage("error-no-data")
        case .error, .appError:
            return UIImage.bundleImage("error-no-network")
        case .custom(let image, _, _):
            return image
        case .customView:
            return nil
        }
    }
    
    var desc: String {
        switch self {
        case .noData:
            return "暂无数据"
        case .error(let error):
            return error.localizedDescription
        case .appError(let message):
            return message
       case .custom(_, let desc, _):
            return desc
        case .customView:
            return ""
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .noData:
            return "重新加载"
        case .error, .appError:
            return "点击重试"
       case .custom(_, _, let title):
            return title
        case .customView:
            return ""
        }
    }
}

/// 显示空数据或者网络请求错误的 UIViewController
final class EmptyErrorCtrlr: UIViewController {
    
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
        if case let EmptyError.customView(customView, inset) = error {
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
        
        let retryBtn = UIButton.universalButton(title: error.buttonTitle)
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
            retryBtn.width(50%).centerHorizontally() ~ 44,
            0
        )
        
        retryBtn.isBottomSpaceReserved = true
        retryBtn.collapseVertically = onRetry == nil ? true : false
    }
}
