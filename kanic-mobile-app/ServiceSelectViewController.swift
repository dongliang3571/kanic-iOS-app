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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ServiceSelectViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceSelectCell", forIndexPath: indexPath) as! ServiceSelectTableViewCell
        var textLabel = UILabel(frame: CGRect(x: CGFloat(10), y: CGFloat(5), width: CGFloat(200), height: CGFloat(30)))
        var rowText = [String]()
        if indexPath.section == 0 {
            rowText = ["Choose your vehicle", "Choose a service"]
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            textLabel.text = rowText[indexPath.row]
            cell.addSubview(textLabel)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = ["Car and Service", "Date and Time", "Location"]
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        var textLabel = UILabel(frame: CGRect(x: CGFloat(10), y: CGFloat(0), width: CGFloat(200), height: CGFloat(30)))
        
        textLabel.text = headerText[section]
        header.addSubview(textLabel)
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
//    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        var temp = indexOfNumbers as NSArray
//        return temp.indexOfObject(title)
//    }
}
