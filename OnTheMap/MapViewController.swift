//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/11/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import UIKit
import MapKit
import SafariServices


class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()
    let viewText = MKPinAnnotationView()
    
    
    
    var locations = StudentLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSudentLocations()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.addAnnotations(((UIApplication.shared.delegate as? AppDelegate)?.studentLocations)!)
    }
    
    func getSudentLocations() {
        let urlString = Parse.PARSE.BASEURL
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.addValue(Parse.ParseParameterKeys.appId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Parse.ParseParameterKeys.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("1", forHTTPHeaderField: "X-Parse-REST-Limit")
        
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
            print("failed")
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
                    DispatchQueue.main.async {
                        self.mapView.addAnnotations(((UIApplication.shared.delegate as? AppDelegate)?.studentLocations)!)
                    }
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
            
            
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "location") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "location")
            
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.canShowCallout = true
        
        let btn = UIButton(type: .detailDisclosure)
        
        annotationView!.rightCalloutAccessoryView = btn
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("tapped")
        
        if let mediaURL = view.annotation as? StudentLocation,
            let stringURL = mediaURL.mediaURL {
            
            if let url = URL(string: stringURL) {
                if url.scheme != nil {
                    let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                    present(vc, animated: true, completion: nil)
                } else {
                    let newUrlString = "http://www.\(stringURL)"
                    let newURL = URL(string: newUrlString)
                    let vc = SFSafariViewController(url: newURL!, entersReaderIfAvailable: true)
                    present(vc, animated: true, completion: nil)
                }
                
            } else {
                print("failed")
            }
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func pinButtonPressed(_ sender: Any) {
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        
    }
    
}
