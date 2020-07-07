//
//  DispatchQueue+Ext.swift
//  WordCard
//
//  Created by CP3 on 4/9/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation

extension DispatchQueue {
    // delay 单位秒
    func delay(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
