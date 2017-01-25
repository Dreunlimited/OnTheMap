//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/12/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import Foundation


struct Udacity {
    
    static let helper = Udacity()
    
    struct UDACITY {
        static let ApiScheme = "https://"
        static let ApiHost = "udacity.com/api/session"
        static let BASEURL = ApiScheme + ApiHost
        
    }
    
    struct UDACITYParameterKeys {
        static let udacity = "udacity"
    }
    
    struct UDACITYParameterValues {
        static var userId = "userID"
        static var sessionId = "sessionId"
        
    }
    
    func parseData(_ jsonData:Data) {
        guard let results = try? JSONSerialization.jsonObject(with: jsonData.subdata(in: Range(uncheckedBounds: (lower: jsonData.startIndex.advanced(by: 5), upper: jsonData.endIndex))), options: .allowFragments) as AnyObject? else {
            print("failed")
            return
        }
    
        guard let key = results?["account"] as? [String:Any], let id = results?["session"] as? [String:Any] else {
            return
        }
        let accountKey = key["key"]!
        let sessionID = id["id"]!
        
        UDACITYParameterValues.sessionId = sessionID as! String
        UDACITYParameterValues.userId = accountKey as! String
    }
    
}
