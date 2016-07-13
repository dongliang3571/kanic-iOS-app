//
//  Make.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/2/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class Make: NSObject {
    var id: Int?
    var name: String?
    var niceName: String?
    
    init(MakeDictionary: NSDictionary) {
        id = MakeDictionary["id"] as? Int
        name = MakeDictionary["name"] as? String
        niceName = MakeDictionary["niceName"] as? String
    }
    
    class func serializeData(MakeArray: [NSDictionary]) -> [Make] {
        var makes = [Make]()
        for make in MakeArray {
            let makeSerialized = Make(MakeDictionary: make)
            makes.append(makeSerialized)
        }
        return makes
    }
}
