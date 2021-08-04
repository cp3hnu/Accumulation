//
//  NSDictionary+Unicode.swift
//  hnup
//
//  Created by CP3 on 16/6/2.
//  Copyright © 2016年 DataYP. All rights reserved.
//

import Foundation

#if DEBUG
extension NSDictionary {
    public static func transform() {
        var sourceSelector: Selector = #selector(description)
        var destinationSelector: Selector = #selector(gbk)
        
        transformSelector(sourceSelector, destinationSelector)
        
        sourceSelector = #selector(NSDictionary.description(withLocale:))
        destinationSelector = #selector(gbkWithLocale(_:))
        
        transformSelector(sourceSelector, destinationSelector)
    }
    
    private static func transformSelector(_ source: Selector, _ destination: Selector) {
        let originalMethod = class_getInstanceMethod(self, source)!
        let extendedMethod = class_getInstanceMethod(self, destination)!
        
        if (class_addMethod(self, source, method_getImplementation(extendedMethod), method_getTypeEncoding(extendedMethod))) {
            class_replaceMethod(self, destination, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, extendedMethod);
        }
    }
    
    @objc private func gbk() -> String {
        let desc = gbk()
        return transfromUnicodeString(desc)
    }
    
    @objc private func gbkWithLocale(_ locale: AnyObject?) -> String {
        let desc = gbkWithLocale(locale)
        return transfromUnicodeString(desc)
    }
    
    private func transfromUnicodeString(_ desc: String) -> String {
        let tempStr1 = desc.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        do {
            let returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
            return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
        } catch {
            return desc
        }
    }
}
#endif
