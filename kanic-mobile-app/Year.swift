//
//  Year.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class Year: NSObject {
    var makeID: Int? = nil
    var name: String? = nil
    var niceName: String? = nil
    var year: [Int]? = nil
    
    init(YearDictionary: NSDictionary) {
        makeID = YearDictionary["make_id"] as? Int
        name = YearDictionary["name"] as? String
        niceName = YearDictionary["niceName"] as? String
        year = YearDictionary["years"] as? [Int]
    }
    
    class func serializeData(YearArray: [NSDictionary]) -> [Year] {
        var years = [Year]()
        for year in YearArray {
            let yearSerialized = Year(YearDictionary: year)
            years.append(yearSerialized)
        }
        return years
    }

}
