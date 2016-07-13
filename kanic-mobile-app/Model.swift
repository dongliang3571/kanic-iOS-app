//
//  Model.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class Model: NSObject {
    var id: Int?
    var make: String?
    var makeID: Int?
    var name: String?
    var niceName: String?
    var year: Int?
    
    init(ModelDictionary: NSDictionary) {
        id = ModelDictionary["id"] as? Int
        make = ModelDictionary["make"] as? String
        makeID = ModelDictionary["make_id"] as? Int
        name = ModelDictionary["name"] as? String
        niceName = ModelDictionary["niceName"] as? String
        year = ModelDictionary["years"] as? Int
    }
    
    class func serializeData(ModelArray: [NSDictionary]) -> [Model] {
        var models = [Model]()
        for model in ModelArray {
            let modelSerialized = Model(ModelDictionary: model)
            models.append(modelSerialized)
        }
        return models
    }
    
}
