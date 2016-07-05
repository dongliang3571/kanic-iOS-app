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
        
        logOutButton.addTarget(self, action: #selector(logOutAction), forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
