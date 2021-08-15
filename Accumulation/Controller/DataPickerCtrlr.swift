//
//  DataPickerCtrlr.swift
//  TiCheBang
//
//  Created by CP3 on 2017/10/9.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking

/// 单行或多行数据选择器
public protocol DataPickerItem {
    var displayName: String { get }
    var nextItems: [DataPickerItem]? { get }
}

extension DataPickerItem {
    public var nextItems: [DataPickerItem]? {
        return nil
    }
}

extension Array where Element: DataPickerItem {
    public subscript(path: IndexPath) -> [DataPickerItem] {
        var resultItems = [DataPickerItem]()
        var nextItems: [DataPickerItem]? = self
        var index = 0
        while let items = nextItems, index < path.count, path[index] < items.count {
            let itemIndex = path[index] // index < path.count保证不越界
            let item = items[itemIndex] // path[index] < items.count保证不越界
            resultItems.append(item)
            nextItems = item.nextItems
            index += 1
        }
        
        return resultItems
    }
}

extension String: DataPickerItem {
    public var displayName: String {
        return self
    }
}

public final class DataPickerCtrlr: UIViewController {
    public struct Style {
        static var titleFont = 16.font
        static var titleColor = 0x333333.hexColor
        static var backgroundColor = UIColor.white
    }

    public var completion: ((IndexPath) -> Void)?
    public var selectedPath: IndexPath
    
    private let pickerView = UIPickerView()
    private let animator = DatePickerAnimator(viewHeight: 260)
    private var pickerTitle: String?
    private let depth: Int
    private let items: [DataPickerItem]
    
    public init(items: [DataPickerItem], depth: Int = 1, title: String? = nil) {
        self.items = items
        self.depth = depth
        pickerTitle = title
        selectedPath = IndexPath(indexes: Array(repeating: 0, count: depth))
    
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = animator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.backgroundColor
        setupView()
    }
}

// MARK: - Setup
private extension DataPickerCtrlr {
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
        
        pickerView.dataSource = self
        pickerView.delegate = self
        for i in 0..<selectedPath.count {
            pickerView.selectRow(selectedPath[i], inComponent: i, animated: false)
        }
        
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
private extension DataPickerCtrlr {
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func done() {
        if items.count > 0 {
            completion?(selectedPath)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension DataPickerCtrlr: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return depth
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var componentItems: [DataPickerItem]? = items
        for idx in 0..<component {
            let index = selectedPath[idx]
            componentItems = componentItems?[index].nextItems
        }
        
        return componentItems?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var componentItems: [DataPickerItem]? = items
        for idx in 0..<component {
            let index = selectedPath[idx]
            componentItems = componentItems?[index].nextItems
        }
        
        return componentItems?[row].displayName
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPath[component] = row
        for idx in component+1..<depth {
            selectedPath[idx] = 0
            pickerView.reloadComponent(idx)
            pickerView.selectRow(0, inComponent: idx, animated: true)
        }
    }
}
