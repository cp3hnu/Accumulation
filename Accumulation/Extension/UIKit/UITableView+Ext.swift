//
//  UITableView+Ext.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/5/26.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    // auto layout 应用于 header view
    public func setAndLayoutTableHeaderView(_ header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size.height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        self.tableHeaderView = header
    }
    
    // auto layout 应用于 footer view
    public func setAndLayoutTableFooterView(_ header: UIView) {
        self.tableFooterView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size.height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        self.tableFooterView = header
    }
}
