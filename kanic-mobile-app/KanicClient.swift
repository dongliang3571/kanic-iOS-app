//
//  KanicClient.swift
//  kanic-mobile-app
//
//  Created by dong liang on 6/29/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

class KanicClient: NSObject {

    let keychain = Keychain(service: "com.kanic-mobile-app")
    
    var baseURL: NSURL?
    var AccessToken: String?
    static var sharedInstance : KanicClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : KanicClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = KanicClient(baseURL: NSURL(string: "http://127.0.0.1:8000/api-beta/")!)
        }
        return Static.instance!
    }
    
    init(baseURL: NSURL) {
        self.baseURL = baseURL
    }
    
    func fetchToken(path: String, username: String, password: String, success: ()->(), failure: ()->()) {
        let targetURL = self.baseURL?.URLByAppendingPathComponent(path)
        let parameters = ["username": username, "password": password]
        let TokenRequest = Alamofire.request(.POST, targetURL!, parameters: parameters)
        
        TokenRequest.responseJSON { response in
            switch response.result {
            case .Success:
                let statusCode = response.response?.statusCode
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    switch statusCode! {
                    case 200...299:
                        self.AccessToken = json["token"].string
                        self.keychain["AccessToken"] = self.AccessToken
                        success()
                    case 400...499:
                        print("JSON: \(json)")
                        print("Request error")
                        failure()
                    case 500...599:
                        print("JSON: \(json)")
                        print("Server error")
                    default:
                        print("JSON: \(json)")
                        print("default error")
                    }
                }
                
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDataFromAPI(path: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, success: ([NSDictionary])->(), failure: ()->()) {
        let targetURL = self.baseURL?.URLByAppendingPathComponent(path)
        let DataRequest = Alamofire.request(.GET, targetURL!, parameters: parameters, headers: headers)
        
        DataRequest.responseJSON { response in
            switch response.result {
            case .Success:
                let statusCode = response.response?.statusCode
                
                if let json = response.result.value as? [NSDictionary] {
                    switch statusCode! {
                    case 200...299:
                        success(json)
                    case 400...499:
                        print("JSON: \(json)")
                        print("Request error")
                    case 500...599:
                        print("JSON: \(json)")
                        print("Server error")
                    default:
                        print("JSON: \(json)")
                        print("default error")
                    }
                } else {
                    print("errors happened when trying to fetch data")
                }
                
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func getModelData(path: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, success: ([NSDictionary])->(), failure: ()->()) {
//        let targetURL = self.baseURL?.URLByAppendingPathComponent(path)
//        let DataRequest = Alamofire.request(.GET, targetURL!, parameters: parameters, headers: headers)
//        
//        
//    }
//    
    
    

}
