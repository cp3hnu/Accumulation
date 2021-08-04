//
//  CPDateFormatter.swift
//  Cards
//
//  Created by CP3 on 2017/10/20.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

public enum CPDateFormatterStyle: String {
    
    /// yyyy-MM-dd HH:mm:ss 例如：2016-01-01 21:01:01
    case dateTime = "yyyy-MM-dd HH:mm:ss"
    
    /// yyyy-MM-dd 例如：2016-01-01
    case date = "yyyy-MM-dd"
    
    /// HH:mm:ss 例如：21:00:00
    case time = "HH:mm:ss"
    
    /// yyyy年M月d日
    case chineseDate = "yyyy年M月d日"
    
    /// yyyy年M月d日 HH:mm:ss EEEE 例如：2016年1月1日 21:01:01 星期天
    case chineseDateTimeAndWeek = "yyyy年M月d日 HH:mm:ss EEEE"
    
    /// yyyyMMddHHmmss 例如：20160101210101
    case dateTimeNoSpace = "yyyyMMddHHmmss"
    
    /// yyyyMMddHHmmssSSS 例如：20160101210101000
    case dateTimeMSNoSpace = "yyyyMMddHHmmssSSS"
}

public final class CPDateFormatter: NSObject {
    
    /// Date, Style -> String
    static func string(from date: Date, style: CPDateFormatterStyle) -> String {
        return string(from: date, format: style.rawValue)
    }
    
    /// Date, Format -> String
    static func string(from date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// String, Style -> Date
    static func date(from string: String, style: CPDateFormatterStyle) -> Date? {
        return date(from: string, format: style.rawValue)
    }
    
    /// String, Format -> Date
    static func date(from string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
}

extension String {
    /// String, Style -> Date
    public func toDate(style: CPDateFormatterStyle) -> Date? {
        return CPDateFormatter.date(from: self, style: style)
    }
    
    /// String, Format -> Date
    public func toDate(format: String) -> Date? {
        return CPDateFormatter.date(from: self, format: format)
    }
}

extension Date {
    /// Date, Style -> String
    public func toString(style: CPDateFormatterStyle) -> String {
        return CPDateFormatter.string(from: self, style: style)
    }
    
    /// Date, Format -> String
    public func toString(format: String) -> String {
        return CPDateFormatter.string(from: self, format: format)
    }
}
