//
//  FileManager.swift
//  MBaaSKit
//
//  Created by Timothy Barnard on 16/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import Foundation

enum File : String {
    case saveJSON = "stringsFile1.json"
    case readJSON = "stringsFile.json"
}


class MyFileManager {
    
    class func downloadStringsFile( newFileName : String ) -> Bool {
        return self.downloadFile(URLPath: URLExtension.jsonFile.rawValue)
    }
    
    private class func downloadFile( URLPath : String ) -> Bool {
        // Correct url and username/password
        print("sendRawTimetable")
        var returnValue = false
        let values = Bundle.contentsOfFile(bundleName: "Info.plist")
        guard let networkURL = values["URL"]  else {
            return returnValue
        }
        let URL = ( networkURL as! String) + URLPath
        let dic = [String: String]()
        HTTPSConnection.post(params: dic, url: URL) { (succeeded: Bool, data: NSData) -> () in
            DispatchQueue.main.async {
                if (succeeded) {
                    self.writeJSONFile(jsonData: data)
                    returnValue = true
                } else {
                    returnValue = false
                }
            }
        }
        return returnValue
    }
    
    private class func readJSONFile( parseKey : String, keyVal : String ) -> String {
        
        var returnStr = ""
        let file = File.readJSON
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file.rawValue) {
            
            let jsonData = NSData(contentsOf: path) // NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
            
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: jsonData as! Data, options: .allowFragments) as! [String:Any]
                
                if let classes = parsedData[parseKey] as? NSArray {
                    
                    for data in classes {
                        print(data)
                        let curData = data as! [String:Any]
                        returnStr = curData[keyVal] as! String
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        return returnStr
    }
    
    private class func readJSONColor( parseKey : String, keyVal : String, defaultCode: (Float, Float, Float) ) -> (Float, Float, Float) {
        
        var returnStr = defaultCode
        let file = File.readJSON
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file.rawValue) {
            
            let jsonData = NSData(contentsOf: path) // NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
            
            do {
                let parsedData = try JSONSerialization.jsonObject(with: jsonData as! Data, options: .allowFragments) as! [String:Any]
                
                if let classes = parsedData[parseKey] as? [String:String] {
                   returnStr = ( Float(classes["red"]!)!, Float(classes["green"]!)!, Float(classes["blue"]!)! )
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        return returnStr
    }
    
    private class func writeJSONFile( jsonData : NSData ) {
        
        let file = File.saveJSON
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first,
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file.rawValue) {
            
            //writing
            do {
                try jsonData.write(to: path, options: .noFileProtection) //text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
        
        /*let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
         let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
         // Write that JSON to the file created earlier
         let jsonFilePath = documentsDirectoryPath.appendingPathComponent("stringsFile.json")
         
         let filemgr = FileManager.default
         
         do {
         print(jsonFilePath)
         //let file = try FileHandle(forWritingTo: jsonFilePath!)
         //file.write(jsonData as Data)
         filemgr.createFile(atPath: "/var/mobile/Containers/Data/Application/5B01763D-D2D9-42BE-87C4-BA9FF8E01201/Documents/stringsFile.json", contents: jsonData as Data, attributes: nil)
         print("JSON data was written to the file successfully!")
         } catch let error as NSError {
         print("Couldn't write to file: \(error.localizedDescription)")
         }*/
    }
}
