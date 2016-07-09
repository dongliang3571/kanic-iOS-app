//
//  YearTableViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class YearTableViewController: UIViewController {
    
    @IBOutlet weak var YearTableView: UITableView!
    
    var make: Make? = nil
    var model: Model? = nil
    var years: Year? = nil
    var yearInt: [Int]? = nil
    var sectionForSelectionViewController: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.YearTableView.delegate = self
        self.YearTableView.dataSource = self
        self.YearTableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Car Year"
        
        let parameters = ["make": "\((self.make?.niceName)!)"]
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        KanicClient.sharedInstance.getDataFromAPI("years", parameters: parameters, headers: headers, success: { (json) in
            self.years = Year.serializeData(json)[0]
            self.yearInt = self.years!.year
            self.YearTableView.reloadData()
            }, failure: {
                print("failed to get year data")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as? YearTableViewCell
        let indexPath = YearTableView.indexPathForCell(cell!)
        let yearInt = self.yearInt![(indexPath?.row)!]
        let modelTableViewController = segue.destinationViewController as! ModelTableViewController
        modelTableViewController.years = self.years
        modelTableViewController.yearInt = yearInt
        modelTableViewController.sectionForSelectionViewController = self.sectionForSelectionViewController
        
        // Change back button attribute
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
 

}

extension YearTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let yearInt = self.yearInt {
            return yearInt.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("YearCell", forIndexPath: indexPath) as! YearTableViewCell
        cell.year = self.yearInt![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
}
