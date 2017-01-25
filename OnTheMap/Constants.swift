//
//  Constants.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/25/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


class Constants {
    static let constants = Constants()
    
    func showAlert(_ message:String?, _ title:String?, _ input:Bool)-> UIAlertController {
        if input == true {
            let alertView = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: title, style: .cancel, handler: nil)
            alertView.addAction(action)
            
            return alertView
            
        } else {
            let alertView = UIAlertController(title: "Cancel", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: title, style: .cancel, handler: nil)
            alertView.addAction(action)
            
            return alertView
        }
    }
    
    func loadSafariView(_ url:String)-> SFSafariViewController {
        let url = URL(string: url)
        let vc = SFSafariViewController(url: url!, entersReaderIfAvailable: true)
        
        return vc
    }
}
