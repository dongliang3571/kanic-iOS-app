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
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let keychain = Keychain(service: "com.kanic-mobile-app")
    
    var sharedInstance: KanicClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        
        usernameLabel.text = "dong"
        passwordLabel.text = "123"
        sharedInstance = KanicClient.sharedInstance
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UISetUp() {
        // Set up main view color
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        
        // Set up sign in button
        self.signInButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.signInButton.layer.cornerRadius = 5
        self.signInButton.layer.borderWidth = 1
        self.signInButton.layer.borderColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0).CGColor
        self.signInButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.signInButton.setTitle("Sign in", forState: UIControlState.Normal)
        signInButton.addTarget(self, action: #selector(loginAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func loginAction(sender: AnyObject) {
        let username = usernameLabel.text
        let password = passwordLabel.text
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Sending request..."
        
        self.sharedInstance?.fetchToken("auth/token", username: username!, password: password!, success: {
            self.performSegueWithIdentifier("loginSegue", sender: self)
            }, failure: { (error1, error2) in
                if let error1 = error1 {
                    print(error1)
                    let alert = UIAlertController(title: "Error", message: "An unexpected error happened", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                } else if let error2 = error2 {
                    let alert = UIAlertController(title: "Invalid Credential", message: "Your username or password does not match", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }
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
        customTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_w")?.imageWithRenderingMode(UIImageRenderingMode.Automatic), selectedImage: UIImage(named: "profile_b"))
        targetController?.viewControllers![1].tabBarItem = customTabBarItem
    }
    
    
}

