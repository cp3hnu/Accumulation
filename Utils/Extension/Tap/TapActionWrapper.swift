//
//  TapActionWrapper.swift
//  WordCard
//
//  Created by CP3 on 11/4/19.
//  Copyright © 2019 CP3. All rights reserved.
//

import Foundation

typealias TapAction = (() -> Void)
class TapActionWrapper {
    let action: TapAction?
    
    init(_ action: TapAction?) {
        self.action = action
    }
}
