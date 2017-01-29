//
//  ClickableUIView.swift
//  ViewDesign
//
//  Created by Timothy Barnard on 15/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class ClickableUIView: UIView {
    
    var moving: Bool = false
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }*/
        self.backgroundColor = UIColor.blue//Color when UIView is clicked.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.moving {
            
            if let touch = touches.first {
                
                let currentPoint = touch.location(in: self)
                // do something with your currentPoint
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y,
                                       width: currentPoint.x, height: currentPoint.y)
            }
        }
        
        self.backgroundColor = UIColor.blue//Color when UIView is clicked.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }*/
        
        self.backgroundColor = UIColor.brown//Color when UIView is not clicked.
        
    }
}
