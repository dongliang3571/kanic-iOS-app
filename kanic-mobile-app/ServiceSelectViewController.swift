//
//  ServiceSelectViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit
import MBProgressHUD

class ServiceSelectViewController: UIViewController {

    private struct staticText {
        //  Static text for this viewController
        static let vcTitle = "Book a Service"
        
        // Static text for cell and section, eg. titles, labels
        static let headerText = ["Car", "Service", "Date and Time", "Location"]
        static let rowText = [["Your Vehicle"], ["Your Service"], ["Date&Time"], ["Location"]]
        static let identifiers = [["vehicleSegue"], ["serviceSegue"], ["dateSegue"], ["locationSegue"]]
        static let HeaderViewIdentifier = "TableViewHeaderView"
        static let cellDetailText = [["Vehicle"], ["Service"], ["Date, Time"], ["Location"]]
    }
    
    //  Storyboard components
    @IBOutlet weak var ServiceSelectTableView: UITableView!
    @IBOutlet weak var NextButton: UIButton!
    
    // Track user current data
    var model: Model?
    var service: Service?
    var scheduledTime: String?
    var location: String?
    
    // Trakc which section user is tapping on
    var currentSection: Int?
    var parameters: [String: AnyObject]?
    
    // Number of row for each section
    var numberRows = [1, 1, 1, 1]
    
    // A reusable label for table header
    var reusedHeaderLabel: UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = staticText.vcTitle
        readDefaultValue()
        UISetUp()
        tableviewSetUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier! {
        case "vehicleSegue":
            let destinationVC = segue.destinationViewController as! MakeViewController
            destinationVC.sectionForSelectionViewController = currentSection
        case "serviceSegue":
            let destinationVC = segue.destinationViewController as! ServiceChooseViewController
            destinationVC.sectionForSelectionViewController = currentSection
        case "confirmRequestSegue":
            let destinationVC = segue.destinationViewController as! ConfirmRequestViewController
            destinationVC.parameters = self.parameters
        default:
            break
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    //  TableView setup
    func tableviewSetUp() {
        self.ServiceSelectTableView.delegate = self
        self.ServiceSelectTableView.dataSource = self
        self.ServiceSelectTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: staticText.HeaderViewIdentifier)
        self.ServiceSelectTableView.rowHeight = UITableViewAutomaticDimension
        self.ServiceSelectTableView.tableFooterView = UIView()
        self.ServiceSelectTableView.reloadData()
    }
    
    //  UI setup
    func UISetUp() {
        // Main view background color
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        // Setting up attribute for Next Button
        self.NextButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.NextButton.setTitle("Next", forState: UIControlState.Normal)
        self.NextButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.NextButton.addTarget(self, action: #selector(self.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //  Callback function when nextButton is pressed, this will send a service request
    func buttonPressed(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        if self.model != nil && self.service != nil && self.scheduledTime != nil && self.location != nil {
            self.parameters = [
                "location": self.location!,
                "scheduled_time": self.scheduledTime!,
                "car": (self.model!.id)!,
                "service": (self.service!.id)!
            ]
            self.performSegueWithIdentifier("confirmRequestSegue", sender: self)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        } else {
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            print("Need more information for this request in ServiceSelectViewController")
        }
    }
    
    //  Reading default value right after viewDidLoad, car, service, time and location will be loaded from defaults
    func readDefaultValue() {
        //  TODO:
    }
    
    //  Callback function when datepick's value changes
    func datePickerChanged(sender: UIDatePicker) {
        let newIndexPath = NSIndexPath(forRow: 0, inSection: 2)
        let cell = ServiceSelectTableView.cellForRowAtIndexPath(newIndexPath)
        let customDateFormatter = NSDateFormatter()
        customDateFormatter.dateFormat = "eee, MM/dd/yy, HH:mm a"
        let dateString = customDateFormatter.stringFromDate(sender.date)
//        cell?.detailTextLabel?.text = NSDateFormatter.localizedStringFromDate(sender.date, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        cell?.detailTextLabel?.text = dateString
        
        //  Save time string for making request
        customDateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let scheduledTimeString = customDateFormatter.stringFromDate(sender.date)
        self.scheduledTime = scheduledTimeString
    }
    
    func datePickerBegubEditing() {
        print("haha")
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
        // Reuse cell with identifier
//        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceSelectCell", forIndexPath: indexPath) as! ServiceSelectTableViewCell
        // Switch statement for different sections
        switch indexPath.section {
        case 0 where self.model != nil:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "ModelSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            cell.detailTextLabel!.text = "\(model!.make!) \(model!.name!) \(model!.year!)"
            return cell
        case 1 where self.service != nil:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "ModelSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
//            cell.detailTextLabel!.text = services![0].name //  For more than one service
            cell.detailTextLabel!.text = service!.name
            return cell
        case 1:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "ModelSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            cell.detailTextLabel!.text = staticText.cellDetailText[indexPath.section][indexPath.row]
            return cell
        case 2 where indexPath.row == 0:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "DateTimeSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.None   // Set cell accessory type to None so that no accessory is going to show
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            cell.detailTextLabel!.text = staticText.cellDetailText[indexPath.section][indexPath.row]
            return cell
        case 2 where indexPath.row == 1:
            let cell = ServiceSelectTableView.dequeueReusableCellWithIdentifier("DateTimeSelectCell", forIndexPath: indexPath) as! ServiceSelectTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.None   // Set cell accessory type to None so that no accessory is going to show
            
            //  time picker
            let height = cell.frame.height  //  Get width of the cell
            let width = cell.frame.width    //  Get height of the cell
            if cell.datePicker == nil {
                cell.datePicker = UIDatePicker(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width, height: height))
                
                // Once the datepicker is initialized, we will set the upper row's detail label to today's date
                let newIndexPath = NSIndexPath(forRow: 0, inSection: 2)
                let upCell = self.ServiceSelectTableView.cellForRowAtIndexPath(newIndexPath)
                let customDateFormatter = NSDateFormatter()
                customDateFormatter.dateFormat = "eee, MM/dd/yy, HH:mm a"
                let dateString = customDateFormatter.stringFromDate(cell.datePicker!.date)
                upCell?.detailTextLabel?.text = dateString
                
                customDateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                let scheduledTimeString = customDateFormatter.stringFromDate(cell.datePicker!.date)
                if self.scheduledTime == nil {
                    self.scheduledTime = scheduledTimeString
                }
            }
            
            
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            cell.datePicker!.addTarget(self, action: #selector(self.datePickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)    //  Added callback action to the time picker
            cell.addSubview(cell.datePicker!)
            return cell
        case 2:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "DateTimeSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            //            cell.detailTextLabel!.text = services![0].name //  For more than one service
            cell.detailTextLabel!.text = service!.name
            return cell
        case 3 where self.location != nil:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "LocationSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            cell.detailTextLabel!.text = self.location
            return cell
        case 3:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "LocationSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            cell.detailTextLabel!.text = staticText.cellDetailText[indexPath.section][indexPath.row]
            return cell
        default:
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "LocationSelectCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator   // Set cell accessory type to DisclosureIndicator, which is an arrow on the right end of the cell
            cell.textLabel!.text = staticText.rowText[indexPath.section][indexPath.row]
            cell.detailTextLabel!.text = staticText.cellDetailText[indexPath.section][indexPath.row]
            return cell
        }
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(staticText.HeaderViewIdentifier)! as UITableViewHeaderFooterView
//        header.textLabel!.text = staticText.headerText[section]
//        return header
//    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return staticText.headerText[section]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentSection = indexPath.section
        switch indexPath.section {
        case 2:
            let newIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)   // create a new IndexPath
            let cell = tableView.cellForRowAtIndexPath(newIndexPath) as? ServiceSelectTableViewCell
            if cell != nil {
                //  Start deleting the row
                self.numberRows[indexPath.section] -= 1
                tableView.beginUpdates()
                tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
                tableView.endUpdates()
            } else {
                //  Start inserting the row
                self.numberRows[indexPath.section] += 1
                tableView.beginUpdates()
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
                tableView.endUpdates()
            }
        default:
            self.performSegueWithIdentifier(staticText.identifiers[indexPath.section][indexPath.row], sender: tableView.cellForRowAtIndexPath(indexPath))
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 2 where indexPath.row == 1:
            return CGFloat(150.0)
        default:
            return CGFloat(44.0)
        }
    }
}
