//
//  FileManager+Ext.swift
//  Cards
//
//  Created by CP3 on 17/5/24.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

extension FileManager {
    public var documentUrl: URL {
        return urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    public var appSupportUrl: URL {
        return urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }
    
    public func fileExists(atUrl url: URL) -> Bool {
        return fileExists(atPath: url.path)
    }
    
    @discardableResult
    public func createFile(atUrl url: URL, contents: Data?, attributes: [FileAttributeKey : Any]?) -> Bool {
        return createFile(atPath: url.path, contents: contents, attributes: attributes)
    }
    
    @discardableResult
    public func createDirectoryIfNotExists(url: URL) -> Bool {
        if !fileExists(atUrl: url) {
            do {
                try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Create Directory(\(url)) Error = \(error)")
                return false
            }
        }
        
        return true
    }
    
    public func isFile(atUrl url: URL) -> Bool {
        var isDir: ObjCBool = false
        if fileExists(atPath: url.path, isDirectory: &isDir) {
            return !isDir.boolValue
        } else {
            return false
        }
    }
}
