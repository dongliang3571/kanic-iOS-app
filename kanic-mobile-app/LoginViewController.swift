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
    
    
}

