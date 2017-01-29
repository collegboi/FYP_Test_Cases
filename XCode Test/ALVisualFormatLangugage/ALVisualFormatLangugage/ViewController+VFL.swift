//
//  ViewController+VFL.swift
//  ALVisualFormatLangugage
//
//  Created by Timothy Barnard on 04/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

extension ViewController {
    
    func setupVFLConstraints() {
        
        self.views["colorView"] = self.colorView
        self.views["spacerView1"] = self.spacerView1
        
        self.views["colorName"] = self.colorName
        self.views["spacerView2"] = self.spacerView2
        
        self.views["colorRedValue"] = self.colorRedValue
        self.views["colorBlueValue"] = self.colorBlueValue
        self.views["colorGreenValue"] = self.colorGreenValue
        self.views["spacerView3"] = self.spacerView3
        
        self.views["redSlider"] = self.redSlider
        self.views["spacerView4"] = self.spacerView4
        
        self.views["greenSlider"] = self.greenSlider
        self.views["spacerView5"] = self.spacerView5
        
        self.views["blueSlider"] = self.blueSlider
        self.views["spacerView6"] = self.spacerView6
        
        self.views["alphaSlider"] = self.alphaSlider
        self.views["spacerView7"] = self.spacerView7
        
        self.views["doneButton"] = self.doneButton
        self.views["cancelButton"] = self.cancelButton
        
        
        
        let size = self.view.frame.width - 60
        let textSize = ( size / 3 )
        
        let imageSize = size * 0.3
        let width = ( imageSize / 2 )
        
        let metrics = ["edgeSpacing": 30, "spacingBetween": 5]
        
        self.addConstraint(contraintStr: "H:|-\(width)-[colorView]-\(width)-|")
        //self.addConstraint(contraintStr: "V:|-15-[colorView]-15-|")
        
        self.addConstraint(contraintStr: "H:|-30-[colorName]-30-|")
        
        /*make spacers have equal width, and greater than 5, make all views center align vertically
        let constH = NSLayoutConstraint.constraints(withVisualFormat:
            "V:|-edgeSpacing-[colorView]-[spacerView1(>=spacingBetween)]-[colorName]-[spacerView2(==spacerView1)]-[colorBlueValue]-[spacerView3(==spacerView1)]-[redSlider]-edgeSpacing-|",
                                                    options: .alignAllCenterX, metrics: metrics, views: views)
        allConstraints += constH
        
        configure label1 vertical alignment
        let constV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-edgeSpacing-[label1]-edgeSpacing-|", options: .alignAllCenterY, metrics: metrics, views: views)
        allConstraints += constV
        
        //make spacers have equal height
        let constVForSpacer1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-edgeSpacing-[spacer1(==spacer2)]-edgeSpacing-|", options: [], metrics: metrics, views: views)
        allConstraints += constVForSpacer1
        
        let constVForSpacer2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-edgeSpacing-[spacer2(==spacer3)]-edgeSpacing-|", options: [] , metrics: metrics, views: views)
        allConstraints += constVForSpacer2*/

        
        //V - colorView
        self.addConstraint(contraintStr: "V:|-30-[colorView(\(imageSize))]")
        
        //V- colorName
        self.addConstraint(contraintStr: "V:[colorView(\(imageSize))]-[spacerView1(>=spacingBetween)]-[colorName]", options: .alignAllCenterX, metrics: metrics )

        //V- colorValues
        self.addConstraint(contraintStr: "V:[colorName]-[spacerView2(==spacerView1)]-[colorRedValue]")
        self.addConstraint(contraintStr: "V:[colorName]-[spacerView2]-[colorGreenValue]")
        self.addConstraint(contraintStr: "V:[colorName]-[spacerView2]-[colorBlueValue]")
        
        //H- colorValues
        self.addConstraint(contraintStr: "H:|-30-[colorRedValue(\(textSize))]-[colorBlueValue(\(textSize))]-[colorGreenValue(\(textSize))]")
        
        //H- SliderViews
        self.addConstraint(contraintStr: "H:|-30-[redSlider]-30-|")
        self.addConstraint(contraintStr: "H:|-30-[greenSlider]-30-|")
        self.addConstraint(contraintStr: "H:|-30-[blueSlider]-30-|")
        self.addConstraint(contraintStr: "H:|-30-[alphaSlider]-30-|")
        
        //V- SliderViews
        self.addConstraint(contraintStr: "V:[colorBlueValue]-[spacerView3(==spacerView1)]-[redSlider]")
        self.addConstraint(contraintStr: "V:[redSlider]-[spacerView4(==spacerView1)]-[greenSlider]")
        self.addConstraint(contraintStr: "V:[greenSlider]-[spacerView5(==spacerView1)]-[blueSlider]")
        self.addConstraint(contraintStr: "V:[blueSlider]-[spacerView6(==spacerView1)]-[alphaSlider]")
        
        //H- Buttons
        self.addConstraint(contraintStr: "H:|-30-[doneButton(100)]")
        self.addConstraint(contraintStr: "H:[cancelButton(100)]-30-|")
        
        //V- Buttons
        self.addConstraint(contraintStr: "V:[alphaSlider]-[spacerView7(==spacerView1)]-[doneButton]-30-|")
        self.addConstraint(contraintStr: "V:[alphaSlider]-[spacerView7]-[cancelButton]-30-|")
        
        
        NSLayoutConstraint.activate(self.allConstraints)
        
    }
    
    
    func addConstraint( contraintStr: String, options: NSLayoutFormatOptions = [], metrics: [String:Any] = [:] ) {
        
        let nsLayoutConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: contraintStr,
            options: options,
            metrics: metrics,
            views: views)
        allConstraints += nsLayoutConstraint
    }
    
}

private extension UIView {
    
    func addToDictionary( allViews: inout [String: UIView] ) {
        
       
        
    }
    
}

/*
import UIKit

extension NSObject {
    func propertysNames() -> [String]{
        var count : UInt32 = 0
        let classToInspect = type(of: self)
        let properties : UnsafeMutablePointer <objc_property_t> = class_copyPropertyList(classToInspect, &count)
        var propertyNames : [String] = []
        let intCount = Int(count)
        for i in 0 ..< intCount {
            let property : objc_property_t = properties[i]
            let propertyName = NSString(utf8String: property_getName(property))!
            propertyNames.append(propertyName as String)
        }
        free(properties)
        return propertyNames
    }
}
 */
