//
//  LocationViewController.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/5/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit
import GoogleMaps
import MBProgressHUD

class LocationViewController: UIViewController {
    
    // Google Maps variables
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        self.navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true

        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false

    }
    
    func UISetUp() {
        // Main view background color
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
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

}

// Handle the user's selection.
extension LocationViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWithPlace place: GMSPlace) {
//        searchController?.active = false
        let previousVC = self.navigationController?.viewControllers[1] as? ServiceSelectViewController
        previousVC?.location = place.formattedAddress
        let section = NSIndexPath(forRow: 0, inSection: 3)
        previousVC?.ServiceSelectTableView.reloadRowsAtIndexPaths([section], withRowAnimation: UITableViewRowAnimation.Right)
        self.navigationController?.popViewControllerAnimated(true)
//        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: NSError) {
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
//    func resultsController(resultsController: GMSAutocompleteResultsViewController, didSelectPrediction prediction: GMSAutocompletePrediction) -> Bool {
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        return true
//    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
