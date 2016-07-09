//
//  ModelTableViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ModelTableViewController: UIViewController {

    @IBOutlet weak var ModelTableView: UITableView!
    
    var years: Year? = nil
    var yearInt: Int? = nil
    var models: [Model]? = nil
    var sectionForSelectionViewController: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ModelTableView.delegate = self
        self.ModelTableView.dataSource = self
        self.ModelTableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Car Model"
        
        let parameters = ["make":  "\((self.years?.niceName)!)", "year": "\(self.yearInt!)"]
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        KanicClient.sharedInstance.getDataFromAPI("models", parameters: parameters, headers: headers, success: { (json) in
            self.models = Model.serializeData(json)
            self.ModelTableView.reloadData()
            }, failure: {
                print("fails to get model data")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    }

}

extension ModelTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let models = self.models {
            return models.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ModelCell", forIndexPath: indexPath) as! ModelTableViewCell
        cell.model = self.models![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let targetViewController = self.navigationController?.viewControllers[1] as? ServiceSelectViewController
        targetViewController?.model = self.models![indexPath.row]
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        targetViewController!.ServiceSelectTableView.reloadSections(NSIndexSet(index: self.sectionForSelectionViewController!), withRowAnimation: UITableViewRowAnimation.Right)
    }
}

