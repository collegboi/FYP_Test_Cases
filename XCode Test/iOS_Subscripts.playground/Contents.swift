import UIKit


let jsonObject: [String: AnyObject] = [
    "age": 21 as AnyObject,
    "name": "Timothy" as AnyObject,
    "transfer": [
        "startDate": "10/04/2015 12:45",
        "endDate": "10/04/2015 16:00"
    ] as AnyObject
]

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}

extension String {
    
    func get() -> String {
        return "Tester"
    }
}

protocol ObjectMapper {
    func mbMapOjects()
}


class MBObject: ObjectMapper {

    
    var map = jsonObject//[String:AnyObject]()
    var className : String?
    var dict = Dictionary<String, Any>()
    var serverDict = Dictionary<String, Any>()
    
    init() {
        self.mbMapOjects()
    }
    
    func mbMapOjects() {
        
    }
    
    func sendToServer(className:String) {
        self.dict[className] = self.JSONDictionary()
    }
    
    func getClassName( className : AnyObject )->String {
        return String(describing: className.self).lowercased()
    }
    
}
extension MBObject {
    
    //@discardableResult
    func JSONDictionary() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        
        let mirror = Mirror(reflecting:self)
        
        for (_, attr) in mirror.children.enumerated() {
            
            if let property_name = attr.label  as String! {
                //print(attr.value)
                //guard attr.value != nil else {
                //    continue
                // }
            
                //{
                    dict[property_name] = attr.value
                //}
                // print("\(property_name) = \(attr.value)")
            }
        }
        return dict
    }
    
}


class Transfer: MBObject  {
    
    dynamic var startDate : String = ""
    dynamic var endDate : String = ""
    
    override func mbMapOjects() {
        let className = self.getClassName(className: self)
        let classMap = self.map[className]
        self.startDate = classMap?["startDate"] as! String
        self.endDate = classMap?["endDate"] as! String
    }
}

class User: MBObject {
    
    dynamic var name : String = ""
    dynamic var age : Int = 0
    var transfer : Transfer?
    
    override func mbMapOjects() {
        self.name = map["name"] as! String
        self.age = map["age"] as! Int
        self.transfer = Transfer()
    }
}


let newUser = User()

//print(#keyPath(User.age))
//print(#keyPath(User.name))

newUser.name = "George"
newUser.age = 31

//newUser.serverDict = newUser.JSONDictionary()/
//newUser.serverDict["transfer"] = newUser.transfer?.JSONDictionary()
//print(newUser.serverDict)


print(newUser.name)
print(newUser.age)
print(newUser.transfer!.endDate)


//newUser.sendToServer(className: "User")
//print(newUser.dict)

