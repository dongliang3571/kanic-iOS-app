//
//  ProfileViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/4/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UISetUp() {
        // Set up log out button
        self.logOutButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.logOutButton.layer.cornerRadius = 5
        self.logOutButton.layer.borderWidth = 1
        self.logOutButton.layer.borderColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0).CGColor
        self.logOutButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.logOutButton.setTitle("Log out", forState: UIControlState.Normal)
        self.logOutButton.addTarget(self, action: #selector(logOutAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func logOutAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        self.presentViewController(vc!, animated: true, completion: nil)
    
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
