//
//  String+Extensions.swift
//  DropboxMediaKit
//
//  Created by Garrett Richards on 1/1/16.
//  Copyright © 2016 bluwave. All rights reserved.
//

import Foundation

extension String {
    
    public func stringByAppendingPathComponent(pathComponent: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(pathComponent)
    }

    public func lastPathComponent() -> String {
        return (self as NSString).lastPathComponent
    }
    
    public func pathExtension() -> String {
        return (self as NSString).pathExtension
    }
    
    public func toURL() -> NSURL? {
        return NSURL(string: self)
    }

    public func removeNameSpace() -> String? {
        let nonNameSpacedClassName = self.componentsSeparatedByString(".").last
        return  nonNameSpacedClassName
    }
}