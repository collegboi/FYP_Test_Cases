//
//  ViewController.swift
//  BaaSKitTestApp
//
//  Created by Timothy Barnard on 17/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit



class DatabaseObj {
    
    var properties = Dictionary<String,AnyObject>()
    
    subscript(key: String) -> AnyObject? {
        return properties[key]
    }
    
    private var tableNameDic : [String:String] = ["name": ""]
    private var dataValuesDic = [String:String]()
    private var dataDic = [ String : [String:String] ]()
    
    var tableName : String {
        
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
    
    func sendObject() {
        
    }
    
    func findObject( property :  String , name : String ) {
        
    }
    

    func findObject() {
        
        var searchParams = [String : String]()
        
        let mirrored_object = Mirror(reflecting: self)
        
        for (_, attr) in mirrored_object.children.enumerated() {
            if let property_name = attr.label  as String! {
                guard attr.value is String else {
                    continue
                }
                searchParams[property_name] = attr.value as? String
               // print("\(property_name) = \(attr.value)")
            }
         }
        print(searchParams)
        
        print(self.properties)
        
    }
}

class Person : DatabaseObj {
    
    var name: String = ""
    var age : Int?
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person()
        person.name = "Timothy"
        
        person.findObject()
        
        print(person.age)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

