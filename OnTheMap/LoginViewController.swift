//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/11/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import UIKit

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
        
        if let loggedIn = loginSave.string(forKey: "loggedIn") {
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        } else {
            print("not logged in")
        }
    }
    
    @IBAction func SignupButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignup", sender: self)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard emailText.text != "" || passwordText.text != "" else {
            loginAlert()
            return
        }
        
        getSessionID()
        self.performSegue(withIdentifier: "loginToMain", sender: self)
        loginSave.set(true, forKey: "loggedIn")
    }
    
    func loginAlert() {
        let alert = UIAlertController(title: "Login Error", message: "Please enter an email and password", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func getSessionID() {
        let methodParameters = [Udacity.UDACITYParameterKeys.udacity:[emailText.text, passwordText.text]]
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
    
}
