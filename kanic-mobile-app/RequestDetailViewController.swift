//
//  RequestDetailViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/11/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {
    
    @IBOutlet weak var carOwnerLabel: UILabel!
    @IBOutlet weak var mechanicLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var scheduledTimeLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    
    var request: Request? 

    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        carOwnerLabel.text = request?.carOwner!
        
        if let mechanicName = request?.mechanic {
            mechanicLabel.text = mechanicName
        } else {
            mechanicLabel.text = "To be determined"
        }
        locationLabel.text = request?.location!
        scheduledTimeLabel.text = request?.scheduledTime!
        carLabel.text = request?.car!
        serviceLabel.text = request?.service!
        statusLabel.text = "\((request?.status)!)"
        if let extraInfo = request?.extraInfo {
            extraInfoLabel.text = extraInfo
        } else {
            extraInfoLabel.text = "None"
        }
        createAtLabel.text = request?.createAt!
        // Do any additional setup after loading the view.
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
