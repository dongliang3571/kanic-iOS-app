//
//  MakeViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/2/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class MakeViewController: UIViewController {

    @IBOutlet weak var makeTableView: UITableView!
    
    var makes: [Make]?
    var sectionForSelectionViewController: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeTableView.delegate = self
        self.makeTableView.dataSource = self
//        self.makeTableView.estimatedRowHeight = 4
        self.makeTableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Car Make"
        
        let parameters = ["format": "json"]
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        KanicClient.sharedInstance.getDataFromAPI(URLs.makeList, parameters: parameters, headers: headers, success: {
            (json) in
            self.makes = Make.serializeData(json)
//            self.makeTableView.tableFooterView = UIView()
            self.makeTableView.reloadData()
            
            }, failure: {
                print("These is error in MakeViewController")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MakeTableViewCell
        let indexPath = makeTableView.indexPathForCell(cell)
        let make = makes![(indexPath?.row)!]
        let yearTableViewController = segue.destinationViewController as! YearTableViewController
        yearTableViewController.make = make
        yearTableViewController.sectionForSelectionViewController = self.sectionForSelectionViewController
        
        // Change back button attribute
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }

}

extension MakeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let makes = self.makes {
            return makes.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MakeCell", forIndexPath: indexPath) as! MakeTableViewCell
        cell.make = self.makes![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
}
