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
        
        requestButton.addTarget(self, action: #selector(RequestService), forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RequestService(sender: AnyObject) {
        performSegueWithIdentifier("requestSegue", sender: self)
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
