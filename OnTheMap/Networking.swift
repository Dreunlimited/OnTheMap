//
//  Networking.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/25/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Networking{
    static let networking = Networking()
    let loginSave = UserDefaults.standard
    var locations = StudentLocation()
    
    func getSessionID(email:String, password:String) {
        let methodParameters = [Udacity.UDACITYParameterKeys.udacity:[email, password]]
        let json = try? JSONSerialization.data(withJSONObject: methodParameters)
        let urlString = URL(string: Udacity.UDACITY.BASEURL)
        var request = URLRequest(url: urlString!)
        request.httpMethod = "POST"
        request.httpBody = json
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error == nil  {
                Udacity.helper.parseData(data!)
                
            } else {
                print("Error \(error?.localizedDescription)")
                
                
            }
        }
        
        task.resume()
        
    }
    
    
    func removeSession(){
        let urlString = Parse.PARSE.BASEURL
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("fail")
                return
            }
            
            self.loginSave.removeObject(forKey: "loggedIn")
            
        }
        task.resume()
        
    }

    
    func getSudentLocations() {
        let urlString = Parse.PARSE.BASEURL
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.addValue(Parse.ParseParameterKeys.appId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Parse.ParseParameterKeys.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("100", forHTTPHeaderField: "X-Parse-REST-Limit")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("fail")
                return
            }
            self.parseData(data!)
        }
        task.resume()
    }
    
    func parseData(_ jsonData:Data) {
        guard let results = try? JSONSerialization.jsonObject(with: jsonData) as? [String:Any] else {
            //alert()
            // Update this alert 
            return
        }
        
        for locationJson in (results?["results"] as? [[String: Any]])! {
            if let sObj = locationJson as? [String:AnyObject]{
                if let  firstName = sObj["firstName"] as? String,
                    let _ = sObj["lastName"] as? String,
                    let latitude = sObj["latitude"] as? NSNumber,
                    let longitude = sObj["longitude"] as? NSNumber,
                    let _ = sObj["mapString"] as? String,
                    let mediaURL = sObj["mediaURL"] as? String,
                    let _ = sObj["objectId"] as? String {
                    
                    locations = StudentLocation(name: firstName, type: mediaURL, lat: (latitude.doubleValue), long: (longitude.doubleValue))
                    ((UIApplication.shared.delegate as? AppDelegate)?.studentLocations.append(locations))
                    
                    
                }
                
            }
            
            
        }
        
        
    }

}
