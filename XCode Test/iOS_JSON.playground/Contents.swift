//: Playground - noun: a place where people can play

import UIKit

struct Person {
    var name: String = "John"
    var age: Int = 50
    var dutch: Bool = false
    var address: Address? = Address(street: "Market St.")
}

struct Address {
    var street: String
}

let john = Person()

protocol JSON {
    func toJSON() throws -> AnyObject?
}

extension JSON {
    func toJSON() throws -> AnyObject? {
        
        let mirror = Mirror(reflecting:self)
        var result: [String:AnyObject] = [:]
        for (_, attr) in mirror.children.enumerated() {
            
            if let property_name = attr.label  as String! {
                print(attr.value)
            }
        }

        return result as AnyObject?
        
        if mirror.count > 0  {
            var result: [String:AnyObject] = [:]
            for (key, child) in mirror.children {
                if let value = child.value as? JSON {
                    result[key] = try value.toJSON()
                } else {
                    throw CouldNotSerializeError.NoImplementation(source: self, type: child)
                }
            }
            return result
        }
        return self as? AnyObject
    }
}

extension Person: JSON { }
extension String: JSON { }
extension Int: JSON { }
extension Bool: JSON { }
extension Address: JSON { }
extension Optional: JSON {
    func toJSON() throws -> AnyObject? {
        if let x = self {
            if let value = x as? JSON {
                return try value.toJSON()
            }
            throw CouldNotSerializeError.NoImplementation(source: x, type: reflect(x))
        }
        return nil
    }
}

do {
    try john.toJSON()
} catch {
    print(error)
}
