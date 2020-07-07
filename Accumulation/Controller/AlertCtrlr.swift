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

public enum AlertStyle {
    case desc(String?)
    case attributed(NSAttributedString)
    case custom(AlertContentView)
}

public final class AlertCtrlr: UIViewController {
    
    public struct Style {
        static var titleFont = 20.boldFont
        static var titleColor = UIColor.black
        static var descFont = 18.font
        static var descColor = UIColor.black
        static var buttonFont = 18.font
        static var cancelBtnNorColor = 0x333333.hexColor
        static var cancelBtnHigColor = 0x333333.hexColor
        static var cancelBtnBgNorColor = UIColor.white
        static var cancelBtnBgHigColor = UIColor.white
        static var preferBtnNorColor = UIColor(0, 122, 255)
        static var preferBtnHigColor = UIColor(0, 122, 255)
        static var preferBtnDisColor = 0x999999.hexColor
        static var preferBtnBgNorColor = UIColor.white
        static var preferBtnBgHigColor = UIColor.white
        static var preferBtnBgDisColor = UIColor.white
        static var destructiveBtnNorColor = UIColor.red
        static var destructiveBtnHigColor = UIColor.red
        static var destructiveBtnDisColor = UIColor.red
        static var destructiveBtnBgNorColor = UIColor.white
        static var destructiveBtnBgHigColor = UIColor.white
        static var destructiveBtnBgDisColor = UIColor.white
        static var backgroundColor = UIColor.white
        static var closeTintColor = 0x666666.hexColor
    }
    
    public var dismissed: ((Bool, Any?) -> (Void))?
    public var widthPercentage: CGFloat = 65
    public var destructive: Bool = false
    public var hasClose: Bool = true
    
    public let wrappedView = UIView()
    private let disposeBag = DisposeBag()
    private let titleText: String?
    private let style: AlertStyle
    private let cancelTitle: String?
    private let preferTitle: String?
    private let animator = AlertAnimator()
    
    public init(title: String?, style: AlertStyle, cancelTitle: String? = nil, preferTitle: String?) {
        self.titleText = title
        self.style = style
        self.cancelTitle = cancelTitle
        self.preferTitle = preferTitle
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.animator
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

private extension AlertCtrlr {
    func setupView() {
        view.asv(wrappedView)
        wrappedView.backgroundColor = Style.backgroundColor
        wrappedView.centerInContainer().width(widthPercentage%)
        wrappedView.layer.cornerRadius = 10
        wrappedView.layer.masksToBounds = true
        
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
            let image = UIImage(systemName: "xmark")
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
            let closeBtn = UIButton(type: .custom)
            closeBtn.setImage(image, for: .normal)
            closeBtn.setPreferredSymbolConfiguration(config, forImageIn: .normal)
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
        let horSeperator = UIView.seperator()
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
            
            let verSeperator = UIView.seperator()
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
