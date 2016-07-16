//
//  ServiceChooseViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/4/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ServiceChooseViewController: UIViewController {

    @IBOutlet weak var ServiceTableView: UITableView!
    
    var services: [Service]?
    var sectionForSelectionViewController: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        
        self.ServiceTableView.delegate = self
        self.ServiceTableView.dataSource = self
        self.ServiceTableView.rowHeight = UITableViewAutomaticDimension
        self.ServiceTableView.tableFooterView = UIView()
        self.title = "Choose services"
        
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        KanicClient.sharedInstance.getDataFromAPI("services", headers: headers, success: { (json) in
            self.services = Service.serializeData(json)
            self.ServiceTableView.reloadData()
            }, failure: {
                print("failed to get service data")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ServiceChooseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let services = self.services {
            return services.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceCell", forIndexPath: indexPath) as! ServiceTableViewCell
        cell.service = self.services![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let targetViewController = self.navigationController?.viewControllers[1] as? ServiceSelectViewController
        
        // MARK: This snippet is for when user can request more than one service
        /*
         
        var tempServices: [Service]? = targetViewController?.services
        
        // Check if services in ServiceSelecViewController is empty
        if tempServices != nil {
            var flag: Bool = false
            for each in tempServices! { // iterate through the list check if duplication exists
                if each.id! == services![indexPath.row].id! {
                    flag = true
                    break
                }
            }
            if flag {   // If there is duplication, we print error
                print("duplication exists")
            } else {    // Else we append the service to services in ServiceSelecViewController
                tempServices!.append(self.services![indexPath.row])
            }
        } else { // First service that is chosen by user will be add directly to services in ServiceSelecViewController
            tempServices = [Service]()
            tempServices?.append(self.services![indexPath.row])
        }
        targetViewController?.services = tempServices
        */
        
        targetViewController?.service = self.services![indexPath.row]
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        targetViewController!.ServiceSelectTableView.reloadSections(NSIndexSet(index: self.sectionForSelectionViewController!), withRowAnimation: UITableViewRowAnimation.Right)
    }
}