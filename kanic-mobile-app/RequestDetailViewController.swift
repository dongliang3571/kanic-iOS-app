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
    
    var request: Request? 

    override func viewDidLoad() {
        super.viewDidLoad()
        carOwnerLabel.text = request?.carOwner!
        mechanicLabel.text = request?.mechanic!
        locationLabel.text = request?.location!
        scheduledTimeLabel.text = request?.scheduledTime!
        carLabel.text = request?.car!
        serviceLabel.text = request?.service!
        statusLabel.text = "\(request?.status!)"
        extraInfoLabel.text = request?.extraInfo!
        // Do any additional setup after loading the view.
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
