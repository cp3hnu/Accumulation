//
//  ItemPickerCtrlr.swift
//  Cards
//
//  Created by CP3 on 2018/8/21.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit
import Bricking

public final class ItemPickerCtrlr: UIViewController {
    
    public var completion: ((Int, DataPickerItem) -> Void)?
    public  var selectedIndex: Int?
    
    private let identifier = "Cell"
    private let viewHeight = 260
    private let tableView = UITableView()
    private let animator: DatePickerAnimator!
    private var pickerTitle: String?
    private let items: [DataPickerItem]
    
    public init(items: [DataPickerItem], title: String? = nil) {
        self.items = items
        pickerTitle = title
        animator = DatePickerAnimator(viewHeight: viewHeight.cf)
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = animator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupView()
    }
}

// MARK: - Setup
private extension ItemPickerCtrlr {
    func setupView() {
        let bar = UIToolbar()
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel) { [weak self] in
            self?.cancel()
        }
        let doneItem = UIBarButtonItem(barButtonSystemItem: .cancel) { [weak self] in
            self?.done()
        }
        let flexible1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexible2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let label = UILabel().font(UIFont.titleFont).textColor(UIColor.Text.strong).alignCenter()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        label.text = pickerTitle
        label.adjustsFontSizeToFitWidth = true
        let titleItem = UIBarButtonItem(customView: label)
        
        bar.items = [cancelItem, flexible1, titleItem, flexible2, doneItem]
        
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        view.asv(bar, tableView)
        view.layout(
            0,
            |bar| ~ 44,
            0,
            |tableView| ~ (viewHeight - 44).cf
        )
    }
}

// MARK: - Action
private extension ItemPickerCtrlr {
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func done() {
        if let index = selectedIndex {
            let selItem = items[index]
            completion?(index, selItem)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ItemPickerCtrlr: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.displayName
        cell.textLabel?.font = UIFont.contentFont
        cell.textLabel?.textColor = UIColor.Text.strong
        
        if let index = selectedIndex, indexPath.row == index {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}
