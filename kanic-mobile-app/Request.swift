//
//  Request.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/6/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class Request: NSObject {
    var id: Int?
    var carOwner: String?
    var mechanic: String?
    var location: String?
    var scheduledTime: String?
    var car: String?
    var carID: Int?
    var service: String?
    var serviceID: Int?
    var status: Int?
    var extraInfo: String?
    var createAt: String?
    
    init(RequestDictionary: NSDictionary) {
        self.id = RequestDictionary["id"] as? Int
        self.carOwner = RequestDictionary["car_owner"]!["username"] as? String
        
        if RequestDictionary["mechanic"] as! NSObject != NSNull() {
            let menchanicFirstName = RequestDictionary["mechanic"]!["first_name"] as? String
            let menchanicLastName = RequestDictionary["mechanic"]!["last_name"] as? String
            self.mechanic = "\(menchanicFirstName!) \(menchanicLastName!)"
        } else {
            self.mechanic = nil
        }
        
        self.location = RequestDictionary["location"] as? String
        self.scheduledTime = RequestDictionary["scheduled_time"] as? String
        self.car = RequestDictionary["car"]!["name"] as? String
        self.carID = RequestDictionary["car"]!["id"] as? Int
        self.service = RequestDictionary["service"]!["name"] as? String
        self.serviceID = RequestDictionary["service"]!["id"] as? Int
        self.status = RequestDictionary["status"] as? Int
        self.extraInfo = RequestDictionary["extra_info"] as? String
        self.createAt = RequestDictionary["createAt"] as? String
    }
    
    class func serializeData(RequestArray: [NSDictionary]) -> [Request] {
        var requests = [Request]()
        for request in RequestArray {
            let requestSerialized = Request(RequestDictionary: request)
            requests.append(requestSerialized)
        }
        return requests
    }
}
