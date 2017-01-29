//
//  ViewController.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myImageView: ImageView!
    @IBOutlet weak var myLabelView: LabelView!
    @IBOutlet weak var myButton: Button!
    @IBOutlet weak var myTextField: TextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTextField.delegate = self
        self.myButton.addTarget(self, action: #selector(self.updateValues), for: .touchUpInside)
        //self.getRemoteConfigFiles()
        //self.initAppDesign()
        
        print(RCConfigManager.getMainSetting(name: "url"))
        print(RCConfigManager.getTranslation(name: "greeting"))
    }
    
    func updateValues() {
        //self.getRemoteConfigFiles()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        //self.getRemoteConfigFiles()
        self.initAppDesign()
    }
    
    func initAppDesign() {
        self.myImageView.setupImageView(className: self)
        self.myLabelView.setupLabelView(className: self)
        self.myTextField.setupLabelView(className: self)
        self.myButton.setupButton(className: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

