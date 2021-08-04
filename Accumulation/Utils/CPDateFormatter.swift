//
//  CPDateFormatter.swift
//  Cards
//
//  Created by CP3 on 2017/10/20.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
import ObjectMapper

enum CPDateFormatterStyle: String {
    
    /// yyyy-MM-dd HH:mm:ss 例如：2016-01-01 21:01:01
    case style1 = "yyyy-MM-dd HH:mm:ss"
    
    /// yyyy-MM-dd 例如：2016-01-01
    case style2 = "yyyy-MM-dd"
    
    /// HH:mm:ss 例如：21:00:00
    case style3 = "HH:mm:ss"
    
    /// yyyy年M月d日 HH:mm:ss EEEE 例如：2016年1月1日 21:01:01 星期天
    case style4 = "yyyy年M月d日 HH:mm:ss EEEE"
    
    /// yyyy年M月d日
    case style5 = "yyyy年M月d日"
    
    /// yyyyMMddHHmmss 例如：20160101210101
    case style6 = "yyyyMMddHHmmss"
    
    /// yyyyMMddHHmmssSSS 例如：20160101210101000
    case style7 = "yyyyMMddHHmmssSSS"
    
    /// HH:mm 例如：21:00
    case style8 = "HH:mm"
    
    /// MM-dd 例如：10:01
    case style9 = "MM-dd"
    
    /// yyyy-MM-dd HH:mm 例如：2016-01-01 21:01
    case style10 = "yyyy-MM-dd HH:mm"
}

final class CPDateFormatter: NSObject {
    
    /// Date, Style -> String
    static func string(from date: Date, style: CPDateFormatterStyle) -> String {
        return string(from: date, format: style.rawValue)
    }
    
    /// String, Style -> Date
    static func date(from string: String, style: CPDateFormatterStyle) -> Date? {
        return date(from: string, format: style.rawValue)
    }
    
    /// Date, Format -> String
    static func string(from date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// String, Format -> Date
    static func date(from string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
}

extension String {
    func toDate(style: CPDateFormatterStyle) -> Date? {
        return CPDateFormatter.date(from: self, style: style)
    }
    
    func toDate(format: String) -> Date? {
        return CPDateFormatter.date(from: self, format: format)
    }
}

extension Date {
    func toString(style: CPDateFormatterStyle) -> String {
        return CPDateFormatter.string(from: self, style: style)
    }
    
    func toString(format: String) -> String {
        return CPDateFormatter.string(from: self, format: format)
    }
}

class CPDateFormatTransform: DateFormatterTransform {
    init(style: CPDateFormatterStyle) {
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        super.init(dateFormatter: formatter)
    }
}
