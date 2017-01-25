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
    let loginSave = UserDefaults.standard
    var locations = StudentLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.networking.getSudentLocations()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.addAnnotations(((UIApplication.shared.delegate as? AppDelegate)?.studentLocations)!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.mapView.addAnnotations(((UIApplication.shared.delegate as? AppDelegate)?.studentLocations)!)
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
       if let mediaURL = view.annotation as? StudentLocation,
            let stringURL = mediaURL.mediaURL {
            
            if let url = URL(string: stringURL) {
                if url.scheme != nil {
                    let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                    present(vc, animated: true, completion: nil)
                } else {
                    let newUrlString = "http://\(url)"
                    let newURL = URL(string: newUrlString)
                    let vc = SFSafariViewController(url: newURL!, entersReaderIfAvailable: true)
                    present(vc, animated: true, completion: nil)
                }
                
            } else {
               let vc = Constants.constants.showAlert("Network failed", "Network error", true)
               present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func pinButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        Networking.networking.removeSession()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "login")
        DispatchQueue.main.async {
            self.present(loginVC, animated: true, completion: nil)
            
        }
        
    }
    
}
