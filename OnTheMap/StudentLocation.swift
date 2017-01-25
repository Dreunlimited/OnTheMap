//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/20/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import Foundation
import MapKit

class StudentLocation: NSObject {
    //static let helper = StudentLocation()
    
    var objectId:String?
    var uniqueKey:String?
    var firstName:String?
    var lastName:String?
    var mapString:String?
    var mediaURL:String?
    var location: CLLocation?
    
    override init() {}
    
        init(name:String,type:String, lat:Double, long:Double) {
        self.firstName = name
        self.mediaURL = type
        self.location = CLLocation(latitude: lat, longitude: long)
    }

    
}


extension StudentLocation: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            
            return location!.coordinate
        }
    }
    
    var title: String? {
        get {
            return firstName
        }
    }
    
    var subtitle:String? {
        return mediaURL
    }
}
