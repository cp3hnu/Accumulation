//
//  Optional+Ext.swift
//  WordCard
//
//  Created by CP3 on 3/26/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation

infix operator |== : ComparisonPrecedence

extension Optional where Wrapped: Equatable  {
    /// 有值且值相等时返回true，否则返回false
    public static func |== (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        switch (lhs, rhs) {
        case (.some(let a), .some(let b)):
            return a == b
        default:
            return false
        }
    }
}

/// String nil 转空字符串
extension Optional where Wrapped == String {
    public var nilToEmpty: String {
        if self == Optional.none {
            return ""
        } else {
            return self!
        }
    }
}
