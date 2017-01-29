//
//  ViewController.swift
//  ViewDesign
//
//  Created by Timothy Barnard on 14/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var singleTap: Bool = false
    var movingView: UIView?
    
    var startingPoint: CGPoint?
    
    var direction: UISwipeGestureRecognizerDirection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveUIView(_ sender: Any) {
     
        
        
    }
    
    @IBAction func addUIView(_ sender: Any) {
        self.addAlertSheet(sender as! UIBarButtonItem)
    }
    
    func addAlertSheet(_ sender: UIBarButtonItem  ) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let view = UIAlertAction(title: "UIView", style: .default, handler: { (action) -> Void in
            
            let newView = ClickableUIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100) )
            newView.backgroundColor = .blue
            newView.center = self.view.center
            newView.isUserInteractionEnabled = true
            newView.isMultipleTouchEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
            panGesture.minimumNumberOfTouches = 2
            newView.addGestureRecognizer(panGesture)
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTaps))
            gestureRecognizer.numberOfTapsRequired = 2
            newView.addGestureRecognizer(gestureRecognizer)
            
            let singleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
            singleGestureRecognizer.numberOfTapsRequired = 1
            //newView.addGestureRecognizer(singleGestureRecognizer)
            
            self.view.addSubview(newView)
        })
    
        alertController.addAction(view)
        
        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        
        alertController.addAction(buttonCancel)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = CGRect(x : self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func handleTaps(_ gestureRecognizer: UITapGestureRecognizer ) {
        
        if let view = gestureRecognizer.view {
            print("double tap")
            (view as! ClickableUIView).moving = !(view as! ClickableUIView).moving
        }
    }
    
    func handleSingleTap( _ gestureRecognizer: UITapGestureRecognizer ) {
            //print(singleTap)
        //if let view = gestureRecognizer.view {
        singleTap = !singleTap
        //}
        print(singleTap)
    }
    
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer ) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            if !singleTap {
                let translation = gestureRecognizer.translation(in: self.view)
                // note: 'view' is optional and need to be unwrapped
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y +     translation.y)
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            }
        }
    }

    func handlePinch(_ sender: UIPinchGestureRecognizer  ) {
    
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
}


