//
//  FormValidator.swift
//  iBeauty
//
//  Created by cp3hnu on 2021/8/11.
//

import Foundation

public protocol RuleType {
    func validate(value: Any?) -> Bool
}

public struct RequiredRule: RuleType {
    public func validate(value: Any?) -> Bool {
        return value != nil
    }
}

public struct NotEmptyRule: RuleType {
    public func validate(value: Any?) -> Bool {
        if let valueStr = value as? String {
            return valueStr != ""
        }
        return false
    }
}

public struct EquatableRule<T: Equatable>: RuleType {
    private let value: T
    public init(_ value: T) {
        self.value = value
    }
    public func validate(value: Any?) -> Bool {
        if let valueT = value as? T {
            return valueT == self.value
        }
        return false
    }
}

public struct MaxRule: RuleType {
    private let max: Int
    public init(_ max: Int) {
        self.max = max
    }
    public func validate(value: Any?) -> Bool {
        if let valueInt = value as? Int {
            return valueInt <= max
        }
        return false
    }
}

public struct MinRule: RuleType {
    private let min: Int
    public init(_ min: Int) {
        self.min = min
    }
    public func validate(value: Any?) -> Bool {
        if let valueInt = value as? Int {
            return valueInt >= min
        }
        return false
    }
}

public struct MaxCountRule: RuleType {
    private let maxCount: Int
    public init(_ count: Int) {
        maxCount = count
    }
    public func validate(value: Any?) -> Bool {
        if let valueStr = value as? String {
            return valueStr.count <= maxCount
        } else if let valueArr = value as? [Any] {
            return valueArr.count <= maxCount
        }
        return false
    }
}

public struct MinCountRule: RuleType {
    private let minCount: Int
    public init(_ count: Int) {
        minCount = count
    }
    public func validate(value: Any?) -> Bool {
        if let valueStr = value as? String {
            return valueStr.count >= minCount
        } else if let valueArr = value as? [Any] {
            return valueArr.count >= minCount
        }
        return false
    }
}

public class FormRule {
    public let rule: RuleType
    public let message: String
    
    public init(_ rule: RuleType, message: String) {
        self.rule = rule
        self.message = message
    }
}

public final class FormValidator {
    private let rules: [String: [FormRule]]
    public init(rules: [String: [FormRule]]) {
        self.rules = rules
    }
    
    public func validate(form: KeyValuePairs<String, Any?>) -> (result: Bool, message: String?) {
        for (key, value) in form {
            guard let formRules = rules[key] else { continue }
            for formRule in formRules {
                if !formRule.rule.validate(value: value) {
                    return (result: false, message: formRule.message)
                }
            }
        }
        return (result: true, message: nil)
    }
}
