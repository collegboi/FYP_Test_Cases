//
//  Log.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 15/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import Foundation

class Log {
    class func msg(message: String,
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        
        let fileNameWithoutPath = fileNameWithPath
        
        #if DEBUG
            let output = "\(NSDate()): \(message) [\(functionName) in \(fileNameWithoutPath), line \(lineNumber)]"
            print(output)
        #endif
    }
    
    class func msg(message: Int,
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        
        let fileNameWithoutPath = fileNameWithPath
        
        #if DEBUG
            let output = "\(NSDate()): \(message) [\(functionName) in \(fileNameWithoutPath), line \(lineNumber)]"
            print(output)
        #endif
    }
    
    
    class func msg(message: Bool,
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        
        let fileNameWithoutPath = fileNameWithPath
        
        #if DEBUG
            let output = "\(NSDate()): \(message) [\(functionName) in \(fileNameWithoutPath), line \(lineNumber)]"
            print(output)
        #endif
    }
    
}
