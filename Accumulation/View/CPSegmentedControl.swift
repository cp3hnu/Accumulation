//
//  CPSegmentedControl.swift
//  hnup
//
//  Created by CP3 on 17/4/5.
//  Copyright © 2017年 DataYP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// 自定义 Segmented Control
public final class CPSegmentedControl: UIControl {
    /// Segment Type
    public enum SegmentedType {
        /// 均分
        case fill
        /// item大小自适应，之间的空格相等
        case fit
    }
    
    public struct Style {
        /// 没有选择的文字颜色
        public static var textColor: UIColor = UIColor.black
        /// 文字字体大小
        public static var textFont: UIFont = UIFont.systemFont(ofSize: 16)
        /// 选中的文字颜色
        public static var highlightedTextColor: UIColor = UIColor.System.tint
        /// 移动的线颜色
        public static var lineColor: UIColor = UIColor.System.tint
        /// 移动的线宽度
        public static var lineWidth: CGFloat = 0.0
        /// 移动的线高度
        public static var lineHeight: CGFloat = 2.0
        /// 移动的线离分割线的距离
        public static var lineSeparatorSpace: CGFloat = 0.0
        /// 分割线颜色
        public static var separatorColor: UIColor = UIColor.clear
        /// 分割线高度
        public static var separatorHeight: CGFloat = 2.0
        /// segment item之间的空格，只在 `fill` 类型下有效
        public static var titleGap: CGFloat = 0.0
    }
    
    /// segment item 切换回调，参数是 segment index
    /// 可以使用这个回调，也可以使用 `self.rx.value` or `self.rx.selectedSegmentIndex`
    public var segmentSelected: ((Int) -> Void)?
    
    private var _selectedSegmentIndex: Int = 0
    /// 当前选中的 segment item index
    
    public var selectedSegmentIndex: Int {
        get {
           return _selectedSegmentIndex
        }
        set(index) {
            selectingSegment(atIndex: index)
        }
    }
    
    /// 没有选择的文字颜色
    public var textColor: UIColor = Style.textColor {
        didSet {
            buttons.forEach { button in
                button.setTitleColor(textColor, for: .normal)
            }
        }
    }
    
    /// 选中的文字颜色
    public var highlightedTextColor: UIColor = Style.highlightedTextColor {
        didSet {
            buttons.forEach { button in
                button.setTitleColor(highlightedTextColor, for: .selected)
            }
        }
    }
    
    /// 文字字体大小
    public var textFont: UIFont = Style.textFont {
        didSet {
            buttons.forEach { button in
                button.titleLabel?.font = textFont
            }
        }
    }
    
    /// 移动的线颜色
    public var lineColor: UIColor = Style.lineColor {
        didSet {
            line.backgroundColor = lineColor
        }
    }
    
    /// 移动的线宽度
    public var lineWidth: CGFloat = Style.lineWidth {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 移动的线高度
    public var lineHeight: CGFloat = Style.lineHeight {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 移动的线离分割线的距离
    public var lineSeparatorSpace: CGFloat = Style.lineSeparatorSpace {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 分割线颜色
    public var separatorColor: UIColor = Style.separatorColor {
        didSet {
            separator.backgroundColor = separatorColor
        }
    }
    
    /// 分割线高度
    public var separatorHeight: CGFloat = Style.separatorHeight {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// segment item之间的空格，只在 `fill` 类型下有效
    public var titleGap: CGFloat = Style.titleGap {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// content inset
    public var contentInset: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            layoutIfNeeded()
        }
    }
    
    private let kButtonBaseTag = 100
    private let items: [String]
    private let type: SegmentedType
    private var buttons = [UIButton]()
    private let line = UIView()
    private let separator = UIView()
    
    // MARK: - Init
    /// 初始化
    /// - Parameters:
    ///   - items: title 数组
    ///   - type: 类型
    public init(items: [String], segmentedType type: SegmentedType = .fill) {
        self.items = items
        self.type = type
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        for (idx, title) in items.enumerated() {
            let button = UIButton()
            button.tag = kButtonBaseTag + idx
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = textFont
            button.setTitleColor(textColor, for: .normal)
            button.setTitleColor(highlightedTextColor, for: .selected)
            button.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
        buttons.first?.isSelected = true
        line.backgroundColor = lineColor
        addSubview(separator)
        addSubview(line)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let selectedButton = buttons[_selectedSegmentIndex]
        let width = frame.width
        let height = frame.height
        let count = CGFloat(buttons.count)
        
        if type == .fill {
            let buttonWidth = (width - (count - 1) * titleGap - contentInset.left - contentInset.right) / count
            for (idx, button) in buttons.enumerated() {
                button.frame = CGRect(x: contentInset.left + CGFloat(idx) * (buttonWidth + titleGap), y: contentInset.top, width: buttonWidth, height: height - contentInset.top - contentInset.bottom)
            }
            
            line.frame = CGRect(x: 0, y: height - contentInset.bottom - lineHeight - lineSeparatorSpace, width: lineWidth > 0 ? lineWidth : buttonWidth, height: lineHeight)
            line.center.x = selectedButton.center.x
        } else {
            var originX = contentInset.left
            var allBtnsWidth: CGFloat = 0
            for button in buttons {
                button.sizeToFit()
                allBtnsWidth += button.bounds.width
            }
            let titleGap = (width - allBtnsWidth - contentInset.left - contentInset.right) / (count - 1)
            for button in buttons {
                let buttonWidth = button.bounds.width
                button.frame = CGRect(x: originX, y: contentInset.top, width: buttonWidth, height: height - contentInset.top - contentInset.bottom)
                originX += buttonWidth + titleGap
            }
            
            line.frame = CGRect(x: 0, y: height - contentInset.bottom - lineHeight - lineSeparatorSpace, width: lineWidth > 0 ? lineWidth : selectedButton.bounds.width, height: lineHeight)
            line.center.x = selectedButton.center.x
        }
        
        separator.frame = CGRect(x: 0, y: height - contentInset.bottom - separatorHeight, width: width, height: separatorHeight)
    }
    
    override public var intrinsicContentSize : CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}

// MARK: - API
public extension CPSegmentedControl {
    /// 切换到某 segment item
    /// - Parameters:
    ///   - index: index 从 0 开始
    ///   - animated: 是否动画，默认没有动画
    func selectingSegment(atIndex index: Int, animated: Bool = false) {
        guard index != _selectedSegmentIndex else { return }
        
        _selectedSegmentIndex = index
        
        buttons.forEach { $0.isSelected = false }
        let selectedButton = buttons[_selectedSegmentIndex]
        selectedButton.isSelected = true
        
        func moveLine() {
            if type == .fit && self.lineWidth == 0 {
                self.line.bounds.size.width = selectedButton.bounds.width
            }
            self.line.center.x = selectedButton.center.x
        }
       
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                moveLine()
            })
        } else {
           moveLine()
        }
    }
}

// MARK: - Private
private extension CPSegmentedControl {
    @objc func tap(_ button: UIButton) {
        let idx = button.tag - kButtonBaseTag
        guard idx != _selectedSegmentIndex else { return }
        
        selectingSegment(atIndex: idx, animated: true)
        segmentSelected?(_selectedSegmentIndex)
        self.sendActions(for: UIControl.Event.valueChanged)
    }
}

// MARK: - RxSwift
extension Reactive where Base: CPSegmentedControl {
    /// Reactive wrapper for `selectedSegmentIndex` property.
    public var selectedSegmentIndex: ControlProperty<Int> {
        value
    }
    
    /// Reactive wrapper for `selectedSegmentIndex` property.
    public var value: ControlProperty<Int> {
        let editingEvents: UIControl.Event = [.allEditingEvents, .valueChanged]
        return base.rx.controlProperty(
            editingEvents: editingEvents,
            getter: { segmentedControl in
                segmentedControl.selectedSegmentIndex
            }, setter: { segmentedControl, value in
                segmentedControl.selectedSegmentIndex = value
            }
        )
    }
}
