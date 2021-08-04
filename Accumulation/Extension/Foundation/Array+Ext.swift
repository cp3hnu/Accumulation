//
//  Array+Ext.swift
//  Accumulation
//
//  Created by CP3 on 8/5/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation

extension Array {
    /// 根据某个属性进行冒泡排序
    public mutating func bubbleSwapProperty<Value>(from: Int, to: Int, property: WritableKeyPath<Element, Value>) {
        guard from >= 0 && to >= 0 && from < count && to < count && from != to else { return }
        
        let by = from < to ? 1 : -1
        for idx in stride(from: from + by, through: to, by: by) {
            let value = self[from][keyPath: property]
            self[from][keyPath: property] = self[idx][keyPath: property]
            self[idx][keyPath: property] = value
        }
    }
}
