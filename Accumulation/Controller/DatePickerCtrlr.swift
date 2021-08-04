//
//  UIPickerCtrlr.swift
//  hnup
//
//  Created by CP3 on 16/6/1.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import UIKit
import Bricking

/// 日期选择器
public final class DatePickerCtrlr: UIViewController {
    public struct Style {
        static var titleFont = 16.font
        static var titleColor = 0x333333.hexColor
        static var backgroundColor = UIColor.white
    }
    
    private let pickerView = UIDatePicker()
    private var pickerTitle: String?
    private let animator = DatePickerAnimator(viewHeight: 260)
    
    /// 设置最小日期
    public var minimumDate: Date? = nil {
        didSet {
            pickerView.minimumDate = minimumDate
        }
    }
    
    /// 设置最大时间
    public var maximumDate: Date? = nil {
        didSet {
            pickerView.maximumDate = maximumDate
        }
    }
    
    /// 设置当前值
    public var currentDate: Date? = nil {
        didSet {
            pickerView.date = currentDate ?? Date()
        }
    }
    
    /// 回调方法，date是选择的日期
    public var completion: ((Date) -> Void)?
    
    public init(pickerMode: UIDatePicker.Mode = .date, date: Date? = nil, title: String? = nil) {
        pickerTitle = title
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .custom
        transitioningDelegate = animator
        
        pickerView.date = date ?? Date()
        pickerView.datePickerMode = pickerMode
        if #available(iOS  13.4, *) {
            pickerView.preferredDatePickerStyle = .wheels
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.backgroundColor
        setupView()
    }
}

private extension DatePickerCtrlr {
    func setupView() {
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let flexible1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexible2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let label = UILabel().font(Style.titleFont).textColor(Style.titleColor).alignCenter()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        label.text = pickerTitle
        label.adjustsFontSizeToFitWidth = true
        let titleItem = UIBarButtonItem(customView: label)
        
        bar.items = [cancelItem, flexible1, titleItem, flexible2, doneItem]
            
        view.asv(bar, pickerView)
        view.layout(
            0,
            |bar| ~ 44,
            0,
            |pickerView.centerHorizontally()| ~ 216
        )
    }
}

// MARK: - Action
private extension DatePickerCtrlr {
    @objc func done() {
        if let completion = completion {
            completion(pickerView.date)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
