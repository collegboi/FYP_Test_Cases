//
//  Error.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 15/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit


class Error {
    
    class func sendError(error: String,
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        
        #if DEBUG
            let output = "\(NSDate()): \(error) [\(functionName) in \(fileNameWithPath), line \(lineNumber)]"
            print(output)
        #endif
    }

}
