//
//  Log.swift
//  DropboxMediaKit
//
//  Created by Garrett Richards on 1/1/16.
//  Copyright © 2016 bluwave. All rights reserved.
//

import Foundation
import XCGLogger

let Logger = Log.sharedInstance

internal class Log {
    internal static let sharedInstance = Log()
    private let internalLogger = XCGLogger.defaultInstance()
    
    private init() {
        internalLogger.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLogLevel: .Debug)
    }
    
    internal func debug(debugString: String) {
        internalLogger.debug(debugString)
    }
    
    internal func info(info: String) {
        internalLogger.info(info)
    }
    
    internal func warning(warning:String) {
        internalLogger.warning(warning)
    }
    
    internal func error(error:String) {
        internalLogger.error(error)
    }
    
    internal func error(error: ErrorType) {
        if let e = error as NSError! {
            internalLogger.error(e.localizedDescription)
        }
    }
}