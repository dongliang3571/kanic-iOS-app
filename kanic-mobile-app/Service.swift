//
//  Service.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/4/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class Service: NSObject {
    var id: Int?
    var name: String?
    var part: String?
    var detail: String?
    var price: Float?
    
    init(ServiceDictionary: NSDictionary) {
        id = ServiceDictionary["id"] as? Int
        name = ServiceDictionary["name"] as? String
        part = ServiceDictionary["part"] as? String
        detail = ServiceDictionary["detail"] as? String
        price = ServiceDictionary["price"] as? Float
    }
    
    class func serializeData(ServiceArray: [NSDictionary]) -> [Service] {
        var services = [Service]()
        for service in ServiceArray {
            let serviceSerialized = Service(ServiceDictionary: service)
            services.append(serviceSerialized)
        }
        return services
    }
}
