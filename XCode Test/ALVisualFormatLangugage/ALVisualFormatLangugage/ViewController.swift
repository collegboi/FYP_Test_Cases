//
//  ViewController.swift
//  ALVisualFormatLangugage
//
//  Created by Timothy Barnard on 04/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var colorView = UIView()
    var spacerView1 = UIView()
    
    var colorName = UITextField()
    var spacerView2 = UIView()
    
    var colorRedValue = UITextField()
    var colorGreenValue = UITextField()
    var colorBlueValue = UITextField()
    var spacerView3 = UIView()
    
    var redSlider = UISlider()
    var spacerView4 = UIView()
    
    var greenSlider = UISlider()
    var spacerView5 = UIView()
    
    var blueSlider = UISlider()
    var spacerView6 = UIView()
    
    var alphaSlider = UISlider()
    var spacerView7 = UIView()
    
    var doneButton = UIButton()
    var cancelButton = UIButton()
    
    var allConstraints = [NSLayoutConstraint]()
    var views = [ String: UIView ]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorView.backgroundColor = UIColor.red
        self.colorView.setupVFL(view: self.view)
        self.spacerView1.setupVFL(view: self.view)
        
        self.colorName.text = "Welcome"
        self.colorName.setupVFL(view: self.view)
        self.colorName.textAlignment = .center
        self.spacerView2.setupVFL(view: self.view)
        
        self.colorRedValue.setupVFL(view: self.view)
        self.colorRedValue.text = "Welcome"
        self.colorRedValue.textAlignment = .center
        
        self.colorGreenValue.setupVFL(view: self.view)
        self.colorGreenValue.text = "Welcome"
        self.colorGreenValue.textAlignment = .center
        
        self.colorBlueValue.setupVFL(view: self.view)
        self.colorBlueValue.text = "Welcome"
        self.colorBlueValue.textAlignment = .center
        self.spacerView3.setupVFL(view: self.view)
        
        self.redSlider.setupVFL(view: self.view)
        self.redSlider.setupColorSlider(color: .red)
        self.spacerView4.setupVFL(view: self.view)
        
        self.greenSlider.setupVFL(view: self.view)
        self.greenSlider.setupColorSlider(color: .green)
        self.spacerView5.setupVFL(view: self.view)
        
        self.blueSlider.setupVFL(view: self.view)
        self.blueSlider.setupColorSlider(color: .blue)
        self.spacerView6.setupVFL(view: self.view)
        
        self.alphaSlider.setupVFL(view: self.view)
        self.alphaSlider.minimumValue = 0
        self.alphaSlider.maximumValue = 1
        self.alphaSlider.value = 1
        self.spacerView7.setupVFL(view: self.view)
        
        self.doneButton.setupVFL(view: self.view, title: "Done", color: .green)
        self.cancelButton.setupVFL(view: self.view, title: "Cancel", color: .red)
        
        
        self.setupVFLConstraints()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIView {
    
    func setupVFL( view: UIView ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
    }
}

private extension UISlider {
    
    func setupColorSlider( color: UIColor ) {
        
        self.maximumValue = 255
        self.minimumValue = 0
        self.value = self.maximumValue / 2
        self.thumbTintColor = color
       // self.isHidden = true
    }
}

private extension UIButton {
    
    
    func setupVFL(view: UIView, title: String, color: UIColor) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
        view.addSubview(self)
        //self.isHidden = true
    }
    
}
