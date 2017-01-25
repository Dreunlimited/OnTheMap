//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/11/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import UIKit
import SafariServices


class LoginViewController: UIViewController {

    var appDelegate: AppDelegate!
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
     let loginSave = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if loginSave.string(forKey: "loggedIn") != nil {
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        } else {
            print("not logged in")
        }
       
    }
    
    @IBAction func SignupButtonPressed(_ sender: Any) {
        let vc = Constants.constants.loadSafariView("http://www.udacity.com")
        present(vc, animated: true, completion: nil)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard emailText.text != "" || passwordText.text != "" else {
            let vc = Constants.constants.showAlert("Email and password did not match.", nil, false)
            present(vc, animated: true, completion: nil)
            return
        }
        Networking.networking.getSessionID(email: emailText.text!, password: passwordText.text!)
        self.performSegue(withIdentifier: "loginToMain", sender: self)
        loginSave.set(true, forKey: "loggedIn")
    }
    
}
