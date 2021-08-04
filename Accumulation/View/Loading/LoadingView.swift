//
//  LoadingView.swift
//  CPLoading
//
//  Created by ZhaoWei on 15/10/12.
//  Copyright © 2015年 CSDEPT. All rights reserved.
//

import UIKit
import RxSwift

open class LoadingView: UIView {
    
    private let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.restartLoading()
                }
            ).disposed(by: disposeBag)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func startLoading() {}
    
    open func stopLoading() {}
    
    open func restartLoading() {}
}









