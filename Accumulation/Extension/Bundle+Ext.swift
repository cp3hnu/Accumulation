//
//  Bundle+Ext.swift
//  WordCard
//
//  Created by CP3 on 5/14/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation

extension Bundle {
    public static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    public static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    }
    
    public static var bundleID: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
    }
}
