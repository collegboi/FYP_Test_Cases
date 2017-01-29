//: Playground - noun: a place where people can play

/*:
 ### Table of Contents
 
 1.[testing]
 2.[testing]
 
 */

import UIKit

//: # Swift 3: JSON-serializable structs using protocols
//: Most of the implementation is based on the code in [this blog post](http://codelle.com/blog/2016/5/an-easy-way-to-convert-swift-structs-to-json/)
import Foundation

//: ### Defining the protocols
protocol JSONRepresentable {
    var JSONRepresentation: AnyObject { get }
}

protocol JSONSerializable: JSONRepresentable {
    
}

extension Dictionary {
    
    func getValueAtIndex( index: Int ) -> ( String, AnyObject ) {
        
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return ( "\(value.0)" , value.1 as AnyObject )
            }
        }
        
        return ("", "" as AnyObject)
    }
}

func convertStringToDictionary(text: String) -> [ String: AnyObject ]? {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            
        } catch let error as NSError {
            print(error)
        }
    }
    return nil
}


func convertStringToObject(text: String) -> ( String, AnyObject ) {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            
            return json!.getValueAtIndex(index: 0)
            
        } catch let error as NSError {
            print(error)
        }
    }
    return ("", "" as AnyObject)
}

func convertToStr( name: Any ) -> AnyObject? {
    
    var returnObject: AnyObject?
    
    if name is String {
        returnObject = name as AnyObject
    }
    
    if name is Int {
        returnObject = name as AnyObject
    }
    
    if name is Float {
        returnObject = name as AnyObject
    }
    
    if name is Double {
        returnObject = name as AnyObject
    }
    
    if name is CGFloat {
        returnObject = name as AnyObject
    }
    
    return returnObject
}


//: ### Implementing the functionality through protocol extensions
extension JSONSerializable {
    var JSONRepresentation: AnyObject {
        var representation = [String: AnyObject]()
        //print(self)
        for case let (label?, value) in Mirror(reflecting: self).children {
        
            //print(value, label)
            
            switch value {
                
            case let value as Dictionary<String, AnyObject>:
                representation[label] = value as AnyObject?
            
            case let value as Array<CGFloat>:
                representation[label] = value as AnyObject?
                
            case let value as Array<String>:
                representation[label] = value as AnyObject?
                
            case let value as Array<AnyObject>:
                var anyObject = [AnyObject]()
                for ( _, objectVal ) in value.enumerated() {
                    var dict = [String:AnyObject]()
                    //print(objectVal)
                    if let jsonVal = objectVal as? JSONRepresentable {
                        
                        let jsonTest = jsonVal as! JSONSerializable
                        //print(jsonTest)
                        if let jsonData = jsonTest.toJSON() {
                            
                            for (index, value) in convertStringToDictionary(text: jsonData) ?? [String: AnyObject]() {
                                
                                dict[index] = value
                            }
                            
                            anyObject.append(dict as AnyObject)
                        }
                    }
                }
                representation[label] = anyObject as AnyObject?
        
                
            case let value as AnyObject:
                if let myVal = convertToStr(name: value) {
                    representation[label] = myVal
                } else {
                    if let jsonVal = value as? JSONRepresentable {
                        var dict = [String:AnyObject]()
                        //print(objectVal)
                        let jsonTest = jsonVal as! JSONSerializable
                        if let jsonData = jsonTest.toJSON() {
                            
                            for (index, value) in convertStringToDictionary(text: jsonData) ?? [String: AnyObject]() {
                                
                                dict[index] = value
                            }
                        }
                        representation[label] = dict as AnyObject
                    } else {
                        //if let test = (value as AnyObject).rawValue as AnyObject? {
                            
                        //}
                        
                        representation[label] = (value as AnyObject).hashValue as AnyObject?
                    }
                }
                
                
            default:
                
                break
            }
        }
        //print(representation)
        return representation as AnyObject
    }
}

extension JSONSerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    func sendInBackground() {
        print("\(type(of: self))")
        
        if let json = self.toJSON() {
            print(json)
        }
    }
}

enum ListType {
    case LanguageType
    case ColorType
    case ControllerType
    
    static func fromHashValue(hashValue: Int) -> ListType {
        switch hashValue {
        case 0:
            return .LanguageType
        case 1:
            return .ColorType
        default:
            return .ControllerType
        }
    }
}


//: ### Define the Structures
//: Notice how they are conforming to the `JSONSerializable` protocol
struct Author: JSONSerializable {
    var name: String
    var age : Int
    var surname : String
    var listType : ListType
}

struct RCColor: JSONSerializable {
    
    var blue : CGFloat!
    var green : CGFloat!
    var red : CGFloat!
    var alpha : CGFloat!
    var name : String!
}
//
//let mycolor =  RCColor(blue: 255, green: 256, red: 266, alpha: 0, name: "blue")
//
//if let json = mycolor.toJSON() {
//    print(json)
//}

//let newAuthor = Author(name: "Clive Cussler",age: 21,surname: "Smith", listType: ListType.ColorType)
//
//if let json = newAuthor.toJSON() {
//    print(json)
//}

func printFonts() {
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames {
        print("------------------------------")
        print("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNames(forFamilyName: familyName )
        print("Font Names = [\(names)]")
    }
}

struct Book: JSONSerializable {
    var title: String
    var isbn: String
    var pages: Int
    
    var authors:[Author]
    var extra:[String: AnyObject]
    var languages : [String]
    
    var mycolor : RCColor
}

//: ### Create a sample object for serialization
let book = Book(
    title: "Mirage",
    isbn: "0399158081",
    pages: 397,
    authors: [
        Author(name: "Clive Cussler",age: 21,surname: "Smith", listType: ListType.fromHashValue(hashValue: 1) ),
        Author(name:"Jack Du Brul", age: 21, surname: "Smith", listType: ListType.fromHashValue(hashValue: 2) )
    ],
    extra: [
        "foo": "bar" as AnyObject,
        "baz": 142.226 as AnyObject
    ],
    languages: ["English", "french"],
    mycolor : RCColor(blue: 255, green: 256, red: 266, alpha: 0, name: "blue")
)

//print("JSON")
//: ### Use the protocols to convert the data to JSON
if let json = book.toJSON() {
    //print(json)
    book.sendInBackground()
}

//let jsonDict = book.map { $0.toJSONDict }
//let jsonData = try! JSONSerialization.dataWithJSONObject(jsonDict, options: [])
//let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)

//printFonts()

enum Role {
    case Developer
    case Manager
    case Architect
}

struct Person {
    var name: String
    var role: Role
}

let staff = [
    Person(name: "Alice", role: .Developer),
    Person(name: "Bob", role: .Manager),
    Person(name: "Clark", role: .Architect),
]

extension Person {
    var toJSONDict : [NSObject:AnyObject] {
        return ["name" as NSObject:name as AnyObject, "role" as NSObject: role.hashValue as AnyObject]
    }
}

let jsonDict = staff.map { $0.toJSONDict }
let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)

//print(jsonString!)





