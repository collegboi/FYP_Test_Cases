//
//  ViewController.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let queue = DispatchQueue(label: "com.barnard.dispatchgroup", attributes: .concurrent, target: .main)
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getRemoteLangFiles()
        self.getRemoteConfigFiles()
        
        //let queue = DispatchQueue(label: "com.allaboutswift.dispatchgroup", attributes: .concurrent, target: .main)
        //let group = DispatchGroup()
        
        group.notify(queue: DispatchQueue.main) {
            self.performSegue(withIdentifier: "mainViewSegue", sender: self)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainViewSegue"
        {
            //if let destinationVC = segue.destination as? ViewController {
                
            //}
        }
    }
    
    func getRemoteConfigFiles() {
        // Correct url and username/password
        
        print("sendRawTimetable")
        let networkURL = "https://timothybarnard.org/Scrap/appDataRequest.php"
        let dic = [String: String]()
        HTTPSConnection.httpRequest(params: dic, url: networkURL, httpMethod: "POST") { (succeeded: Bool, data: NSData) -> () in
            // Move to the UI thread
            
            self.group.enter()
            self.queue.async {
                if (succeeded) {
                    print("Succeeded")
                    RCFileManager.writeJSONFile(jsonData: data, fileType: .config)
                } else {
                    print("Error")
                }
            }
        }
    }
    
    func getRemoteLangFiles() {
        // Correct url and username/password
        
        print("sendRawTimetable")
        let networkURL = "https://timothybarnard.org/Scrap/appDataRequest.php?type=translation&language=English"
        let dic = [String: String]()
        HTTPSConnection.httpRequest(params: dic, url: networkURL, httpMethod: "POST") { (succeeded: Bool, data: NSData) -> () in
            // Move to the UI thread
            
            self.group.enter()
            self.queue.async {
                if (succeeded) {
                    print("Succeeded")
                    RCFileManager.writeJSONFile(jsonData: data, fileType: .language)
                } else {
                    print("Error")
                }
            }
        }
    }


}

