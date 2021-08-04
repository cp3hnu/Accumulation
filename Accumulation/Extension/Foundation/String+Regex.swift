//
//  String+Pattern.swift
//  Cards
//
//  Created by CP3 on 2017/10/13.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

extension String {
    public enum ValidityType {
        /// 手机
        case phone
        /// 银行卡
        case bankCardNo
        /// 邮箱
        case email
        /// 身份证号码
        case idCard
        /// N位数字
        case numberLen(Int)
        /// mix...max位数字
        case numberLenBetween(Int, Int)
        /// 网址
        case website
        
        public var regex: String {
            switch self {
            case .phone:
               return #"^1\d{10}$"#
            case .bankCardNo:
                return #"^\d{15,19}$"#
            case .email:
                return #"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$"#
            case .idCard:
                return #"^(\d{18}|\d{17}(\d|X|x))$"#
            case .numberLen(let length):
                return #"^\d{\#(length)}$"#
            case .numberLenBetween(let min, let max):
                return #"^\d{\#(min),\#(max)}$"#
            case .website:
                return ##"^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"##
            }
        }
    }
    
    public func isValid(_ type: ValidityType) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", type.regex).evaluate(with: self)
    }
    
    /// 这个使用很频繁
    public func isPhone() -> Bool {
        return isValid(.phone)
    }
}
