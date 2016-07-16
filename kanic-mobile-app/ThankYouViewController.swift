//
//  ThankYouViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/15/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    @IBOutlet weak var HomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        // Do any additional setup after loading the view.
    }
    
    func UISetUp() {
        self.HomeButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.HomeButton.layer.cornerRadius = 5
        self.HomeButton.layer.borderWidth = 1
        self.HomeButton.layer.borderColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0).CGColor
        self.HomeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.HomeButton.setTitle("Home", forState: UIControlState.Normal)
        self.HomeButton.addTarget(self, action: #selector(HomeButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
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
    
    func HomeButtonPressed(sender: UIButton) {
        let vc = self.presentingViewController as? UITabBarController
        let nav = vc?.viewControllers![0] as? UINavigationController
        print(nav)
        
        
    
        self.dismissViewControllerAnimated(true, completion: {
            nav!.popToRootViewControllerAnimated(true)
        })
    }

}
