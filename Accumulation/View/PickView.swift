//
//  PickView.swift
//  WordCard
//
//  Created by CP3 on 6/3/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Bricking

public final class PickView: UIView {
    
    public struct Style {
        static var backgroundColor = UIColor.white
    }
    
    public var completion: ((IndexPath) -> Void)?
    public var selectedPath: IndexPath {
        didSet {
            indicatorView.value = getSelectValue()
        }
    }
    
    public var indicatorView: IndicatorFormView!
    private let pickerView = UIPickerView()
    private let depth: Int
    private let items: [DataPickerItem]
    private let barHeight: CGFloat
    private let pickHeight: CGFloat = 216
    private var isExpand = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.invalidateIntrinsicContentSize()
                self.superview?.setNeedsLayout()
                self.superview?.layoutIfNeeded()
                self.indicatorView.indicator.transform = CGAffineTransform(rotationAngle: self.isExpand ? 0.5 * .pi : 0)
            }
        }
    }
    
    public init(title: String, placeholder: String? = nil, items: [DataPickerItem], depth: Int = 1, selectedPath: IndexPath? = nil, barHeight: CGFloat = 44) {
        assert(items.count > 0, "没有选项")
        self.items = items
        self.depth = depth
        self.barHeight = barHeight
        self.selectedPath = selectedPath ?? IndexPath(indexes: Array(repeating: 0, count: depth))
        super.init(frame: CGRect.zero)
    
        self.clipsToBounds = true
        self.backgroundColor = Style.backgroundColor
        indicatorView = IndicatorFormView(title: title, placeholder: placeholder, value: getSelectValue())
        indicatorView.seperator.isHidden = true
        indicatorView.backgroundColor = Style.backgroundColor
        indicatorView.tap = { [unowned self] in
            self.isExpand = !self.isExpand
        }
    
        pickerView.dataSource = self
        pickerView.delegate = self
        for i in 0..<self.selectedPath.count {
            pickerView.selectRow(self.selectedPath[i], inComponent: i, animated: false)
        }
        
        let seperator = UIView.seperator()
        asv(indicatorView, pickerView, seperator)
        layout(
            0,
            |indicatorView| ~ barHeight,
            0,
            |-15-pickerView.centerHorizontally()-15-| ~ pickHeight
        )
        |-15-seperator|.bottom(0).height(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: isExpand ? barHeight + pickHeight : barHeight)
    }
    
    private func getSelectValue() -> String {
        var value = ""
        var curItems: [DataPickerItem]? = items
        var idx = 0
        while curItems != nil && idx < self.selectedPath.count {
            let itemIdx = self.selectedPath[idx]
            guard itemIdx < curItems!.count else {
                print("selectedPath与数据源不一致")
                break
            }
            
            let item = curItems![itemIdx]
            if idx != 0 {
               value += "\\"
            }
            value += item.displayName
            curItems = item.nextItems
            idx += 1
        }
        
        return value
    }
}

extension PickView: UIPickerViewDataSource, UIPickerViewDelegate {
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
        self.isExpand = !self.isExpand
        completion?(selectedPath)
    }
}

