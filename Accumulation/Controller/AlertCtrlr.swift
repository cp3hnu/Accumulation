//
//  AlertCtrlr.swift
//  Cards
//
//  Created by CP3 on 2018/1/18.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit
import Bricking
import RxSwift
import RxCocoa
 
public protocol AlertStyleViewController {
    var wrappedView: UIView { get }
}

/// 自定义 UIAlertView
public protocol AlertViewContent {
    var returnValue: Any? { get }
    var isPreferredEnabled: Observable<Bool> { get }
}

extension AlertViewContent {
    public var returnValue: Any? {
        return nil
    }
    
    public var isPreferredEnabled: Observable<Bool> {
        return Observable<Bool>.just(true)
    }
}

public typealias AlertContentView = UIView & AlertViewContent
extension UILabel: AlertViewContent {}
public final class AlertContainerView: UIView, AlertViewContent {}
extension UITextField: AlertViewContent {
    public var returnValue: Any? {
        return text
    }
    
    public var isPreferredEnabled: Observable<Bool> {
        return self.rx.value.map { text -> Bool in
            !(text ?? "").isEmpty
        }
    }
}

public enum AlertStyle {
    case desc(String?)
    case attributed(NSAttributedString)
    case custom(AlertContentView)
}

public final class AlertCtrlr: UIViewController, AlertStyleViewController {
    public struct Style {
        public static var titleFont = 20.boldFont
        public static var titleColor = UIColor.compLabel
        public static var descFont = 18.font
        public static var descColor = UIColor.compLabel
        public static var buttonFont = 18.font
        public static var cancelBtnNorColor = UIColor.dynamicSecondaryLabel
        public static var cancelBtnHigColor = UIColor.dynamicSecondaryLabel
        public static var preferBtnNorColor = UIColor.systemBlue
        public static var preferBtnHigColor = UIColor.systemBlue
        public static var preferBtnDisColor = UIColor.compTertiaryLabel
        public static var destructiveBtnNorColor = UIColor.systemRed
        public static var destructiveBtnHigColor = UIColor.systemRed
        public static var destructiveBtnDisColor = UIColor.systemRed
        public static var cancelBtnBgNorColor = UIColor.clear
        public static var cancelBtnBgHigColor = UIColor.clear
        public static var preferBtnBgNorColor = UIColor.clear
        public static var preferBtnBgHigColor = UIColor.clear
        public static var preferBtnBgDisColor = UIColor.clear
        public static var destructiveBtnBgNorColor = UIColor.clear
        public static var destructiveBtnBgHigColor = UIColor.clear
        public static var destructiveBtnBgDisColor = UIColor.clear
        public static var backgroundColor = UIColor.compSystemBackground
        public static var closeTintColor = UIColor.dynamicCloseColor
    }
    
    public var dismissed: ((Bool, Any?) -> (Void))?
    public var widthPercentage: CGFloat = 65
    public var widthContant: CGFloat? = nil
    public var destructive: Bool = false
    public var hasClose: Bool = false
    public let animator = AlertAnimator()
    
    public let wrappedView = UIView()
    private let disposeBag = DisposeBag()
    private let titleText: String?
    private let style: AlertStyle
    private let cancelTitle: String?
    private let preferTitle: String?
    
    // MARK: - Init
    public init(title: String?, style: AlertStyle, cancelTitle: String? = nil, preferTitle: String?) {
        self.titleText = title
        self.style = style
        self.cancelTitle = cancelTitle
        self.preferTitle = preferTitle
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.animator
        #if targetEnvironment(macCatalyst)
        animator.bgColorAlpha = 0
        #else
        animator.bgColorAlpha = 0.3
        #endif
    }
    
    public convenience init(title: String?, desc: String?, cancelTitle: String? = nil, preferTitle: String?) {
        self.init(title: title, style: AlertStyle.desc(desc), cancelTitle: cancelTitle, preferTitle: preferTitle)
    }
    
    public convenience init(title: String?, desc: NSAttributedString, cancelTitle: String? = nil, preferTitle: String?) {
        self.init(title: title, style: AlertStyle.attributed(desc), cancelTitle: cancelTitle, preferTitle: preferTitle)
    }
    
    public convenience init(title: String?, contentView: AlertContentView, cancelTitle: String? = nil, preferTitle: String?) {
        self.init(title: title, style: AlertStyle.custom(contentView), cancelTitle: cancelTitle, preferTitle: preferTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.alpha(0)
        setupView()
    }
}

// MARK: - Setup
private extension AlertCtrlr {
    func setupView() {
        view.asv(wrappedView)
        wrappedView.corner(10)
        wrappedView.backgroundColor = Style.backgroundColor
        if let constant = widthContant {
            wrappedView.centerInContainer().width(constant)
        } else {
           wrappedView.centerInContainer().width(widthPercentage%)
        }
        
        let titleLabel = UILabel().font(Style.titleFont).textColor(Style.titleColor).alignCenter().lines(0).text(titleText)
        let contentView = createContentView()
        wrappedView.asv(
            titleLabel,
            contentView
        )
        wrappedView.layout(
            25,
            |-20-titleLabel-20-|,
            20,
            |-20-contentView-20-|
        )
        
        if hasClose {
            let closeBtn = UIButton(type: .custom)
            if #available(iOS 13.0, *) {
                let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
                closeBtn.setPreferredSymbolConfiguration(config, forImageIn: .normal)
                let image = UIImage(systemName: "xmark")
                closeBtn.setImage(image, for: .normal)
            } else {
                closeBtn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            }
            closeBtn.tintColor = Style.closeTintColor
            closeBtn.tap { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }
            wrappedView.asv(closeBtn)
            closeBtn.top(0).trailing(0).width(50).height(50)
        }
        
        if preferTitle != nil {
            let buttonView = createButtonView(contentView: contentView)
            wrappedView.asv(
                buttonView
            )
            wrappedView.layout(
                contentView,
                25,
                |buttonView| ~ 50,
                0
            )
        } else {
            wrappedView.layout(
                contentView,
                0
            )
        }
        
        if case AlertStyle.desc(let text) = style, text == nil {
            contentView.collapseVertically = true
        }
        
        if titleText == nil {
            titleLabel.collapseVertically = true
        }
    }
    
    func createContentView() -> AlertContentView {
        let contentView: AlertContentView
        switch style {
        case .desc(let text):
            let descLabel = UILabel().font(Style.descFont).textColor(Style.descColor).lines(0).alignCenter()
            descLabel.text = text
            contentView = descLabel
        case .attributed(let attributedText):
            let descLabel = UILabel().font(Style.descFont).textColor(Style.descColor).lines(0).alignCenter()
            descLabel.attributedText = attributedText
            contentView = descLabel
        case .custom(let view):
            contentView = view
        }
        return contentView
    }
    
    func createButtonView(contentView: AlertContentView) -> UIView {
        let view = UIView()
        let horSeperator = UIView.separator()
        view.asv(horSeperator)
        |horSeperator| ~ 0.5
        
        let preferButton = UIButton()
        preferButton.setTitle(preferTitle, for: .normal)
        preferButton.titleLabel?.font = Style.buttonFont
        preferButton.setTitleColor(destructive ? Style.destructiveBtnNorColor : Style.preferBtnNorColor, for: .normal)
        preferButton.setTitleColor(destructive ? Style.destructiveBtnHigColor : Style.preferBtnHigColor, for: .highlighted)
        preferButton.setTitleColor(destructive ? Style.destructiveBtnDisColor : Style.preferBtnDisColor, for: .disabled)
        preferButton.setBackgroundColor(destructive ? Style.destructiveBtnBgNorColor : Style.preferBtnBgNorColor, for: .normal)
        preferButton.setBackgroundColor(destructive ? Style.destructiveBtnBgHigColor : Style.preferBtnBgHigColor, for: .highlighted)
        preferButton.setBackgroundColor(destructive ? Style.destructiveBtnBgDisColor : Style.preferBtnBgDisColor, for: .disabled)
        preferButton.tap{ [unowned self] in
            self.dismiss(animated: true, completion: nil)
            self.dismissed?(true, contentView.returnValue)
        }
        contentView.isPreferredEnabled
            .bind(to: preferButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        if cancelTitle != nil {
            let cancelButton = UIButton()
            cancelButton.setTitle(cancelTitle, for: .normal)
            cancelButton.titleLabel?.font = Style.buttonFont
            cancelButton.setTitleColor(Style.cancelBtnNorColor, for: .normal)
            cancelButton.setTitleColor(Style.cancelBtnHigColor, for: .highlighted)
            cancelButton.setBackgroundColor(Style.cancelBtnBgNorColor, for: .normal)
            cancelButton.setBackgroundColor(Style.cancelBtnBgHigColor, for: .highlighted)
            cancelButton.tap { [unowned self] in
                self.dismiss(animated: true, completion: nil)
                self.dismissed?(false, nil)
            }
            
            let verSeperator = UIView.separator()
            view.asv(cancelButton, verSeperator, preferButton)
            |cancelButton--0--verSeperator--0--preferButton|
            preferButton.top(0.5).bottom(0)
            [cancelButton, preferButton].alignTops().alignBottoms().equalWidths()
            verSeperator.top(0.5).bottom(0).width(0.5).centerHorizontally()
        } else {
            view.asv(preferButton)
            preferButton.fillHorizontally().top(0.5).bottom(0)
        }
        
        return view
    }
}
