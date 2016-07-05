//
//  ServiceSelectViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ServiceSelectViewController: UIViewController {

    @IBOutlet weak var ServiceSelectTableView: UITableView!
    
    // Track user current car and service
    var model: Model? = nil
    var services: [Service]? = nil
    
    // A reusable label for table header
    var reusedHeaderLabel: UILabel? = nil
    
    // Header identifier for reusing purposes
    let HeaderViewIdentifier = "TableViewHeaderView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ServiceSelectTableView.delegate = self
        self.ServiceSelectTableView.dataSource = self
        ServiceSelectTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        self.title = "Book a Service"
        self.ServiceSelectTableView.tableFooterView = UIView()
        self.ServiceSelectTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    override func viewDidAppear(animated: Bool) {
//        self.ServiceSelectTableView.reloadData()
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
}

extension ServiceSelectViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRows: [Int]
        if let tempService = self.services {
            numberRows = [tempService.count+1, 2, 1]
        } else {
            numberRows = [1, 1, 2, 1]
        }
        return numberRows[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceSelectCell", forIndexPath: indexPath) as! ServiceSelectTableViewCell
        if cell.reusedRowLabel == nil {
            cell.reusedRowLabel = UILabel(frame: CGRect(x: CGFloat(15), y: CGFloat(5), width: CGFloat(300), height: CGFloat(30)))
        }
        let rowText = [["Choose your vehicle"], ["Choose a service"], ["Date", "Time"], ["Location"]]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        if self.model != nil && indexPath.section == 0 && indexPath.row == 0 {
//            cell.reusedRowLabel!.text = "\(model!.make!) \(model!.name!) \(model!.year!)"
//        }
//        if self.services?.count != nil && indexPath.section == 0 && indexPath.row == 1 {
//            print("im inside service")
//            print(services)
//            cell.reusedRowLabel!.text = services![0].name
//        }
        cell.reusedRowLabel!.text = rowText[indexPath.section][indexPath.row]
        cell.addSubview(cell.reusedRowLabel!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = ["Car", "Service", "Date and Time", "Location"]
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        header.textLabel!.text = headerText[section]
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let identifiers = [["vehicleSegue", "serviceSegue"]]
        self.performSegueWithIdentifier(identifiers[indexPath.section][indexPath.row], sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
//    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        var temp = indexOfNumbers as NSArray
//        return temp.indexOfObject(title)
//    }
}
