//
//  DetailViewController.swift
//  CMSKit
//
//  Created by Timothy Barnard on 04/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var saveButton : UIBarButtonItem?
    var backButton : UIBarButtonItem?
    
    var fullScreenMode : Bool = false {
        didSet {
            self.updateNavigationBar()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.updateNavigationBar()
    }
    
    func updateNavigationBar( ) {
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.updateView) )
        
        if fullScreenMode {
            
            //if let backButton = self.navigationItem.backBarButtonItem {
            if self.backButton != nil {
                print("backbutton")
                self.navigationItem.setLeftBarButtonItems([backButton!, saveButton! ], animated: true)
                
            } else {
                print("no backbutton")
                self.navigationItem.setLeftBarButtonItems([ saveButton! ], animated: true)
            }
        } else {
            self.navigationItem.setLeftBarButtonItems([ saveButton! ], animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController){
            // Your code...
            self.fullScreenMode = false
            self.updateNavigationBar()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:  232/255 , green:  104/255, blue:  80/255, alpha: 1)
        self.navigationItem.title = "Detail"
       
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.updateView) )
        backButton = UIBarButtonItem(title: "◀︎", style: .plain, target: self, action: #selector(self.updateView))
        
        //self.navigationItem.setLeftBarButtonItems([saveButton! ], animated: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView() {
        print("test")
        let vc = self.splitViewController
        UIView.animate(withDuration: 0.5) { () -> Void in
            vc?.preferredDisplayMode = .allVisible
        }

        self.fullScreenMode = false
        self.updateNavigationBar()
        //vc?.preferredDisplayMode = .allVisible
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

