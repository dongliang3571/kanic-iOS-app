//
//  HistoryDisplayViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/11/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class HistoryDisplayViewController: UIViewController {

    @IBOutlet weak var HistoryTableView: UITableView!
    
    var requests:[Request]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        self.HistoryTableView.delegate = self
        self.HistoryTableView.dataSource = self
//        self.makeTableView.estimatedRowHeight = 4
//        self.HistoryTableView.rowHeight = UITableViewAutomaticDimension
        self.title = "History"
        
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        KanicClient.sharedInstance.getDataFromAPI(URLs.requestForCurrentUser, headers: headers, success: {
            (json) in
//            print(json[0]["mechanic"]! as! NSObject == NSNull())
            print("im making request in HostoryDisplayVC")
            self.requests = Request.serializeData(json)
//          self.HistoryTableView.tableFooterView = UIView()
            self.HistoryTableView.reloadData()
            
            }, failure: {
                print("Error happen while fetching all current user's requests ")
        })
    }
    
    func UISetUp() {
        // Main view background color
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! HistoryDisplayTableViewCell
        let indexPath = HistoryTableView.indexPathForCell(cell)
        let targetVC = segue.destinationViewController as? RequestDetailViewController
        targetVC?.request = requests![indexPath!.row]
    }
}

extension HistoryDisplayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let requests = self.requests {
            return requests.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath) as! HistoryDisplayTableViewCell
        cell.request = self.requests![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("requestDetailSegue", sender: self)
//    }
}
