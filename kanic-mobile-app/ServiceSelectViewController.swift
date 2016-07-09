//
//  ServiceSelectViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ServiceSelectViewController: UIViewController {

    struct staticText {
        // Static text for cell and section, eg. titles, labels
        static let headerText = ["Car", "Service", "Date and Time", "Location"]
        static let rowText = [["Choose your vehicle"], ["Choose a service"], ["Choose date and time", "haha"], ["Location search"]]
        static let identifiers = [["vehicleSegue"], ["serviceSegue"], ["dateSegue"], ["locationSegue"]]
        static let HeaderViewIdentifier = "TableViewHeaderView"
    }
    
    @IBOutlet weak var ServiceSelectTableView: UITableView!
    @IBOutlet weak var NextButton: UIButton!
    
    // Track user current data
    var model: Model? = nil
    var services: [Service]? = nil
    var currentSection: Int? = nil
    
    // Number of row for each section
    var numberRows = [1, 1, 1, 1]
    
    // A reusable label for table header
    var reusedHeaderLabel: UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UISetUp()
        self.ServiceSelectTableView.delegate = self
        self.ServiceSelectTableView.dataSource = self
        ServiceSelectTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: staticText.HeaderViewIdentifier)
        self.title = "Book a Service"
        self.ServiceSelectTableView.tableFooterView = UIView()
        self.ServiceSelectTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "vehicleSegue" {
            let destinationVC = segue.destinationViewController as! MakeViewController
            destinationVC.sectionForSelectionViewController = currentSection
        } else if segue.identifier == "serviceSegue" {
            let destinationVC = segue.destinationViewController as! ServiceChooseViewController
            destinationVC.sectionForSelectionViewController = currentSection
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func UISetUp() {
        // Setting up attribute for Next Button
        self.NextButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.NextButton.setTitle("Next", forState: UIControlState.Normal)
        self.NextButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
}

extension ServiceSelectViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return staticText.headerText.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberRows[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceSelectCell", forIndexPath: indexPath) as! ServiceSelectTableViewCell
        if cell.reusedRowLabel == nil {
            cell.reusedRowLabel = UILabel(frame: CGRect(x: CGFloat(15), y: CGFloat(5), width: CGFloat(300), height: CGFloat(30)))
        }
        
//        switch indexPath.section {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if (self.model != nil && indexPath.section == 0 && indexPath.row == 0) {
            cell.reusedRowLabel!.text = "\(model!.make!) \(model!.name!) \(model!.year!)"
        } else if (self.services?.count != nil && indexPath.section == 1 && indexPath.row == 0) {
            cell.reusedRowLabel!.text = services![0].name
        } else {
            cell.reusedRowLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
        }
        
        cell.addSubview(cell.reusedRowLabel!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(staticText.HeaderViewIdentifier)! as UITableViewHeaderFooterView
        header.textLabel!.text = staticText.headerText[section]
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentSection = indexPath.section
        if indexPath.section == 2 && indexPath.row == 0 {
            // Insert a new cell to display timepicker
            let newIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)   // create a new IndexPath
            // Start updating the row
            self.numberRows[indexPath.section] += 1
            tableView.beginUpdates()
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Right)
            tableView.endUpdates()
        } else {
            self.performSegueWithIdentifier(staticText.identifiers[indexPath.section][indexPath.row], sender: tableView.cellForRowAtIndexPath(indexPath))
        }
    }
    
//    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        var temp = indexOfNumbers as NSArray
//        return temp.indexOfObject(title)
//    }
}
