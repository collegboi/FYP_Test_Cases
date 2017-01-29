//
//  Database.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 15/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import Foundation

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}


/*obj = {
    "name" : "car",
    "data" : {
        "_id" : "580247f6d6f45fb748369c3c",
        "make" : "BMW",
        "model" : "318",
        "litre" : "2.0",
        "age" : "10"
    }	
}*/

class DatabaseObj {
    
    
    
    private var tableNameDic : [String:String] = ["name": ""]
    private var dataValuesDic = [String:String]()
    private var dataDic = [ String : [String:String] ]()
    
    @objc var tableName : String {
        
        get {
            guard let tableNameVal = tableNameDic["name"] else {
                return ""
            }
            return tableNameVal
        }
        
        set {
            tableNameDic["name"] = tableName
        }
    }
    
    func addClassData( key : String, value :String ) {
        self.dataValuesDic[key] = value
    }
    
    func setClassData() {
        self.dataDic["data"] = self.dataValuesDic
    }
    
    
}
extension DatabaseObj {
    
    class func sendObject() {
        
    }
    
    class func findObject( property : String , name : String ) {
        
    }
}





