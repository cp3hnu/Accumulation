//
//  GridView.swift
//  Cards
//
//  Created by CP3 on 2018/1/9.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit
import Bricking

final class GridView: UIView {

    var tapAtIndex: ((Int) -> Void)?
    
    init(itemViews: [UIView], numberOfLine: Int, edgeInsets: UIEdgeInsets = UIEdgeInsets.zero, hSpace: CGFloat = 0, vSpace: CGFloat = 0) {
        
        super.init(frame: CGRect.zero)
        itemViews.enumerated().forEach { (idx, view) in
            view.addTapAction { [weak self] in
                self?.tapAtIndex?(idx)
            }
        }
        asv(itemViews)
        itemViews.grid(numberOfLine: numberOfLine, edgeInsets: edgeInsets, hSpace: hSpace, vSpace: vSpace)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
