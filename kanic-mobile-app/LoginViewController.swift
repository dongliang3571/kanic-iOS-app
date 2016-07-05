//
//  ViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 6/15/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let keychain = Keychain(service: "com.kanic-mobile-app")
    
    var sharedInstance: KanicClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = "diana"
        passwordLabel.text = "123"
        sharedInstance = KanicClient.sharedInstance
        signInButton.addTarget(self, action: #selector(loginAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginAction(sender: AnyObject) {
        let username = usernameLabel.text
        let password = passwordLabel.text
        
        self.sharedInstance?.fetchToken("auth/token", username: username!, password: password!, success: {
            self.performSegueWithIdentifier("loginSegue", sender: self)
            }, failure: {
                print("username or password is not correct")
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Tar bar controller
        let targetController = segue.destinationViewController as? UITabBarController
        targetController?.tabBar.tintColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)    // change selected tab bar item color
//        targetController?.tabBar.barTintColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)  // Tab bar background color
        
        //change top bar attributes for navigation controller 1
        var navController = targetController?.viewControllers![0] as? UINavigationController
        navController!.navigationBar.barTintColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)  // Top bar color
        navController?.navigationBar.tintColor = UIColor.whiteColor()  // Set back button arrow color to white
        navController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]  // Title color
        
        // Tab Bar Item 1
        var customTabBarItem: UITabBarItem = UITabBarItem(title: "Service", image: UIImage(named: "wrench_w")?.imageWithRenderingMode(UIImageRenderingMode.Automatic), selectedImage: UIImage(named: "wrench_b"))
//        customTabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.grayColor()], forState:.Normal)  // change text color
        targetController?.viewControllers![0].tabBarItem = customTabBarItem
        
        // Change top bar attributes for navigation controller 2
        navController = targetController?.viewControllers![1] as? UINavigationController    // Top bar color
        navController!.navigationBar.barTintColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        navController?.navigationBar.tintColor = UIColor.whiteColor()  // Set back button arrow color to white
        navController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]  // Title color
        
        // Tab Bar Item 2
        customTabBarItem = UITabBarItem(title: "Service", image: UIImage(named: "profile_w")?.imageWithRenderingMode(UIImageRenderingMode.Automatic), selectedImage: UIImage(named: "profile_b"))
        targetController?.viewControllers![1].tabBarItem = customTabBarItem
    }
    
    
}

