//
//  ConfirmRequestViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/15/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit
import MBProgressHUD

class ConfirmRequestViewController: UIViewController {
    
    @IBOutlet weak var extraInfoTextView: UITextView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    var parameters: [String: AnyObject]?
    var extraInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        // Do any additional setup after loading the view.
    }
    
    //  UI setup
    func UISetUp() {
        // Main view background color
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        
        // Setting up attribute for Next Button
        self.confirmButton.backgroundColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0)
        self.confirmButton.setTitle("Request NOW", forState: UIControlState.Normal)
        self.confirmButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.confirmButton.addTarget(self, action: #selector(self.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Setting up UI attribute for extraInfoTextView
        self.extraInfoTextView.delegate = self
        self.extraInfoTextView.backgroundColor = UIColor.whiteColor()
        self.extraInfoTextView.layer.cornerRadius = 5
        self.extraInfoTextView.layer.borderWidth = 1
        self.extraInfoTextView.layer.borderColor = UIColor(red:0.22, green:0.72, blue:0.62, alpha:1.0).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.DeterminateHorizontalBar
        hud.labelText = "loading"
        
        self.tabBarController?.tabBar.userInteractionEnabled = false
        self.navigationController?.navigationBar.userInteractionEnabled = false
        self.view.userInteractionEnabled = false
        let headers = ["Authorization": "JWT \(KanicClient.sharedInstance.AccessToken!)"]
        var parameters = self.parameters
        parameters!["extra_info"] = self.extraInfoTextView.text
        KanicClient.sharedInstance.makeServiceRequest(URLs.requestCreate, parameters: parameters, headers: headers, success: { (json) in
            print(json)
            // Present modally thank you view
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let thanYouViewController = storyboard.instantiateViewControllerWithIdentifier("thankYouView") as! ThankYouViewController
            self.navigationController!.presentViewController(thanYouViewController, animated: true, completion: nil)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, failure: {
                print("error happened while making post request in ConfirmRequestVC")
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
        
        
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

extension ConfirmRequestViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        self.placeHolderLabel.hidden = true
    }
}
