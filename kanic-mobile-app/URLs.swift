//
//  URLs.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/11/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class URLs: NSObject {
    //  Base URL
    static let baseURL = "http://127.0.0.1:8000/api-beta/"
    
    //  URLs for users
    static let userCreate = "users/create"
    static let userRetrieve = "users/profile"
    
    //  URLs for services
    static let serviceList = "services?format=json"
    static let serviceRetrieve = "services/<id>"
    
    //  URLs for requests
    static let requestCreate = "requests/create"
    static let requestForCurrentUser = "requests/current-user"
    static let requestRetrieve = "requests/<id>"
    
    //  URLs for cars
    static let makeList = "vehicle/makes"
    static let modelList = "vehicle/models"
    static let yearList = "vehicle/years"
}
