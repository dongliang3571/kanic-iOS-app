//
//  ServiceTabViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/2/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ServiceTabViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RequestService(sender: AnyObject) {
        performSegueWithIdentifier("requestSegue", sender: self)
    }
    
    func UISetUp() {        
//        set up for button
        self.requestButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.requestButton.layer.cornerRadius = 5
        self.requestButton.layer.borderWidth = 1
        self.requestButton.layer.borderColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0).CGColor
        self.requestButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.requestButton.addTarget(self, action: #selector(RequestService), forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
}
