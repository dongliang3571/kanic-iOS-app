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

class ViewController: UIViewController {
    
    @IBOutlet weak var onwerLabel: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var dateTimeLabel: UITextField!
    @IBOutlet weak var carLabel: UITextField!
    @IBOutlet weak var serviceLabel: UITextField!
    @IBOutlet weak var completeLabel: UILabel!
    
    let keychain = Keychain(service: "com.kanic-mobile-app")
    var requestUrl = "http://104.236.60.23/api-beta/requests/create/"
    var authToken: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        authToken = keychain["token"]
        
        
    }
    

    @IBAction func requestButtonPressed(sender: AnyObject) {
        let owner = self.onwerLabel.text
        let location = self.locationLabel.text
        let dateTime = self.dateTimeLabel.text
        let car = self.carLabel.text
        let service = self.serviceLabel.text
        
        let parameters = "car_owner=\(owner!)&location=\(location!)&scheduled_time=\(dateTime!)&car=\(car!)&service=\(service!)"
        
        let url = NSURL(string: self.requestUrl)
        var mutableURLRequest = NSMutableURLRequest(URL: url!)
        mutableURLRequest.setValue("JWT \(self.authToken!)", forHTTPHeaderField: "Authorization")
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        var manager = Alamofire.Manager.sharedInstance
        var makeRequest = manager.request(mutableURLRequest)
        
        
        
        makeRequest.responseJSON { response in
            switch response.result {
            case .Success:
                let statusCode = response.response?.statusCode
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    switch statusCode! {
                    case 200...299:
                        print("JSON: \(json)")
                    case 400...499:
                        print("JSON: \(json)")
                        print("Server response no")
                    case 500...599:
                        print("JSON: \(json)")
                        print("Server error")
                    default:
                        print("JSON: \(json)")
                        print("default error")
                    }
                }
                
                
                
            case .Failure(let error):
                print(error)
            }        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

