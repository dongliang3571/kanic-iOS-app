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
    var request: Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HistoryTableView.delegate = self
        self.HistoryTableView.dataSource = self
//        self.makeTableView.estimatedRowHeight = 4
//        self.HistoryTableView.rowHeight = UITableViewAutomaticDimension
        self.title = "History"
        
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        KanicClient.sharedInstance.getDataFromAPI("requests/user", headers: headers, success: {
            (json) in
//            print(json[0]["mechanic"]! as! NSObject == NSNull())
            self.requests = Request.serializeData(json)
//          self.HistoryTableView.tableFooterView = UIView()
            self.HistoryTableView.reloadData()
            
            }, failure: {
                print("These is error")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let targetVC = segue.destinationViewController as? RequestDetailViewController
        targetVC?.request = self.request
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
        self.request = self.requests![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("requestDetailSegue", sender: self)
    }
}
