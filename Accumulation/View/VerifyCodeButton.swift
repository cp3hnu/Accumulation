//
//  VerifyCodeButton.swift
//  Cards
//
//  Created by CP3 on 2017/10/16.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import RxSwift

/// 验证码 UIButton
public final class VerifyCodeButton: UIButton {
    public struct Style {
        public static var normalColor: UIColor = UIColor.mainColor
        public static var disabledColor: UIColor = UIColor.mainColor.alpha(0.3)
        public static var font: UIFont = 14.font
        // 是否带边框
        public static var borderWidth: CGFloat = 0
        public static var borderColor: UIColor = UIColor.mainColor
        public static var disabledBorderColor: UIColor = UIColor.mainColor.alpha(0.3)
    }
    
    // 是否有边框
    public var borderWidth = Style.borderWidth
    // 边框颜色
    public var borderColor = Style.borderColor
    public var disabledBorderColor = Style.disabledBorderColor
    
    // 按钮外部使能条件，比如要输入手机号码
    public var isExternalEnabled = false {
        didSet {
            if !isCountingDown {
                isEnabled = isExternalEnabled
            }
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            if (borderWidth > 0) {
                self.layer.borderColor = isEnabled ? borderColor.cgColor : disabledBorderColor.cgColor
            }
        }
    }
    
    private let disposeBag = DisposeBag()
    private var timerDisposeBag = DisposeBag()
    private var isCountingDown = false
    private let totalSeconds: Int
    private var enterBackgroundTime: Date?
    private var remainingSeconds: Int = 0 {
        didSet {
            if remainingSeconds > 0 {
                setTitle("(\(remainingSeconds)s)重发", for: .normal)
            } else {
                setTitle("重新发送", for: .normal)
                stopCountingDown()
            }
        }
    }
    
    public init(seconds: Int = 60) {
        totalSeconds = seconds
        super.init(frame: CGRect.zero)
        setTitle("发送验证码", for: .normal)
        setTitleColor(Style.normalColor, for: .normal)
        setTitleColor(Style.disabledColor, for: .disabled)
        titleLabel?.font = Style.font
        if Style.borderWidth > 0 {
            self.layer.borderWidth = Style.borderWidth
        }
        isEnabled = false
        notificationObserver()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startCountingDown() {
        isEnabled = false
        isCountingDown = true
        remainingSeconds = totalSeconds
        setupTimer()
    }
    
    public func reset() {
        remainingSeconds = 0
    }
}

private extension VerifyCodeButton {
    func setupTimer() {
        Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] a in
                    self?.remainingSeconds -= 1
                }
            ).disposed(by: timerDisposeBag)
    }
    
    func stopCountingDown() {
        timerDisposeBag = DisposeBag()
        
        isCountingDown = false
        isEnabled = isExternalEnabled
    }
    
    func notificationObserver() {
        NotificationCenter.default.rx
            .notification(UIApplication.didEnterBackgroundNotification)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.enterBackgroundTime = Date()
                }
            ).disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.computeBackgroundDuration()
                }
            ).disposed(by: disposeBag)
    }
    
    func computeBackgroundDuration() {
        guard isCountingDown else { return }
        guard let date = enterBackgroundTime else { return }
        let elapse = Int(Date().timeIntervalSince(date))
        remainingSeconds = max(0, remainingSeconds - elapse)
    }
}

extension Reactive where Base: VerifyCodeButton {
    public var isExternalEnabled: Binder<Bool> {
        return Binder(self.base) { button, enabled in
            button.isExternalEnabled = enabled
        }
    }
}
