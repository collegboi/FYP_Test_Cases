//
//  MasterViewController.swift
//  CMSKit
//
//  Created by Timothy Barnard on 04/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]()
    
    var mySplitViewController: UISplitViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.tableView.backgroundColor = UIColor.darkGray


        objects += ["English", "French", "Spanish", "Italian", "Russian", "Polish"]
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //self.navigationItem.rightBarButtonItem = addButton
        mySplitViewController = self.splitViewController
        
        if mySplitViewController != nil {
            
            let controllers = mySplitViewController?.viewControllers
            self.detailViewController = (controllers?[(controllers?.count)!-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        //objects.insert(NSDate(), at: 0)
        //let indexPath = IndexPath(row: 0, section: 0)
        //self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.mySplitViewController?.toggleMasterView()
                let object = objects[indexPath.row] //as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.fullScreenMode = true
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] //as! NSDate
        cell.textLabel!.text = object//.description
        cell.textLabel?.backgroundColor = UIColor.white
        cell.backgroundColor = UIColor.darkGray
        cell.selectionStyle = UITableViewCellSelectionStyle(rawValue: 3)!
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension UISplitViewController {
    func toggleMasterView() {
        var nextDisplayMode: UISplitViewControllerDisplayMode
        switch(self.preferredDisplayMode){
        case .primaryHidden:
            nextDisplayMode = .primaryHidden
        default:
            nextDisplayMode = .primaryHidden
            //nextDisplayMode = .primaryHidden
        }
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.preferredDisplayMode = nextDisplayMode
        }
    }
}
