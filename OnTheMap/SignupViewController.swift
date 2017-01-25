//
//  SignupViewController.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/19/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       webView.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let stringValue =  "https://www.google.com".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        let stringUrl = URL(string: stringValue!)
        let request = URLRequest(url: stringUrl!)
        
        self.webView.loadRequest(request)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finish loading")
    }

}
