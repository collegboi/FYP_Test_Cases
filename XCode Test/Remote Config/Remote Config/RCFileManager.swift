//
//  RCFileManager.swift
//  Remote Config
//
//  Created by Timothy Barnard on 29/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

enum RCFile : String {
    case saveConfigJSON = "configFile1.json"
    case readConfigJSON = "configFile.json"
    case saveLangJSON = "langFile1.json"
    case readLangJSON = "langFile.json"
}

enum RCFileType {
    case config
    case language
}


class RCFileManager {
    
    class func readJSONFile( fileName: RCFile ) -> Data? {
        
        var returnData : Data?
        
        let file = fileName.rawValue
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file) {
            
            returnData = NSData(contentsOf: path) as Data?
        }
        return returnData
    }
    
    class func getJSONDict( parseKey : String, keyVal : String ) -> [String:Any] {
        
        var returnStr = [String:Any]()
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
                
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
               
            for( value ) in parsedData["controllers"] as! NSArray {
                    
                guard let dict = value as? [String:Any] else {
                    break
                }
                    
                guard let controllerName = dict["name"] as? String else {
                    break
                }
                    
                if controllerName == parseKey {
                    
                    for ( object ) in dict["objectsList"] as! NSArray {
                        
                        if let newobject = object as? [String: AnyObject ] {
                            
                            guard let objectName = newobject["objectName"] as? String else {
                                break
                            }
                            if objectName == keyVal {
                                
                                guard let propertiesList = newobject["objectProperties"] as? [String:Any] else {
                                    break
                                }
                                returnStr = propertiesList
                            }
                            
                        }
                    }
                }
                
            }
            
        } catch let error as NSError {
                print(error)
        }
        return returnStr
    }
    
    class func readJSONColor( keyVal : String ) -> UIColor? {
        
        var returnColor : UIColor?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnColor
        }
         
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
                
            for ( color ) in parsedData["colors"] as! NSArray {
                    
                guard let nextColor = color as? [String:Any] else {
                    break
                }
                guard let colorName = nextColor["name"] as? String else {
                    break
                }
                if colorName == keyVal {
                        
                    guard let red = nextColor["red"] as? Float else {
                        break
                    }
                    guard let green = nextColor["green"] as? Float else {
                        break
                    }
                    guard let blue = nextColor["blue"] as? Float else {
                        break
                    }
                    guard let alpha = nextColor["alpha"] as? Float else {
                        break
                    }
                        
                    returnColor =  UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
                    break
                }
            }
         
        } catch let error as NSError {
            print(error)
        }
        return returnColor
    }
    
    class func readJSONMainSettings( keyName: String ) -> String? {
        
        var returnStr: String?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readConfigJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            guard let translationList = parsedData["mainSettings"] as? [String:String]  else {
                return returnStr
            }
            
            guard let valueName = translationList[keyName] else {
                return returnStr
            }
            
            returnStr = valueName
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }
    
    class func readJSONTranslation( keyName: String ) -> String? {
        
        var returnStr: String?
        
        guard let jsonData = RCFileManager.readJSONFile(fileName: .readLangJSON) else {
            return returnStr
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            
            guard let translationList = parsedData["translationList"] as? [String:String]  else {
                return returnStr
            }
            
            guard let valueName = translationList[keyName] else {
                return returnStr
            }
            
            returnStr = valueName
            
        } catch let error as NSError {
            print(error)
        }
        
        
        return returnStr
    }
    
    class func deleteJSONFileName( fileName: String ) -> Bool {
        
        var returnBool = false
        var fileNotFound = false
        
        let fileManager = FileManager.default
        let tempFolderPath = NSTemporaryDirectory()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                print(filePath)
                if filePath == fileName {
                    try fileManager.removeItem(atPath: NSTemporaryDirectory() + filePath)
                    returnBool = true
                    fileNotFound = false
                    break
                } else {
                    fileNotFound = true
                }
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
        
        return returnBool || fileNotFound
    }
    
    
    class func checkFilesExists( fileName: String) -> Bool {
        
        var fileFound = false
        
        let fileManager = FileManager.default
        let tempFolderPath = NSTemporaryDirectory()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                print(filePath)
                if filePath == fileName {
                    fileFound = true
                    break
                } else {
                    fileFound = false
                }
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
        return fileFound
    }
    
    
    
    class func changeJSONFileName(oldName: String, newName: String) {
        
        if deleteJSONFileName(fileName: newName) {
        
            do {
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let documentDirectory = URL(fileURLWithPath: path)
                let originPath = documentDirectory.appendingPathComponent(oldName)
                let destinationPath = documentDirectory.appendingPathComponent(newName)
                try FileManager.default.moveItem(at: originPath, to: destinationPath)
            } catch {
                print(error)
            }
        }
    }
    
    class func writeJSONFile( jsonData : NSData, fileType : RCFileType ) {
        
        var fileName: String = ""
        
        switch fileType {
        case .language:
            if RCFileManager.checkFilesExists(fileName: RCFile.readLangJSON.rawValue) {
                fileName = RCFile.saveLangJSON.rawValue
            } else {
                fileName = RCFile.readLangJSON.rawValue
            }
        default:
            if RCFileManager.checkFilesExists(fileName: RCFile.readConfigJSON.rawValue) {
                fileName = RCFile.saveConfigJSON.rawValue
            } else {
                fileName = RCFile.readConfigJSON.rawValue
            }
        }
        
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(fileName) {
            print(path)
            
            do {
                try jsonData.write(to: path, options: .noFileProtection) //text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
}
