//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/11/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import UIKit
import SafariServices


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var loginSave = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((UIApplication.shared.delegate as? AppDelegate)?.studentLocations.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListTableViewCell
        
            let title = (UIApplication.shared.delegate as? AppDelegate)?.studentLocations[indexPath.row]
            cell?.nameLabel.text = title?.firstName
            return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = (UIApplication.shared.delegate as? AppDelegate)?.studentLocations[indexPath.row]
        if let url = URL(string: (urlString?.mediaURL)!) {
            if url.scheme == nil {
                let newUrlString = "http://\(url)"
                let newURL = URL(string: newUrlString)
                let vc = SFSafariViewController(url: newURL!, entersReaderIfAvailable: true)
                present(vc, animated: true, completion: nil)
            } else {
                let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                present(vc, animated: true, completion: nil)

            }
        }
        
        
    }
   

    @IBAction func logoutTouched(_ sender: Any) {
        Networking.networking.removeSession()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "login")
        DispatchQueue.main.async {
            self.present(loginVC, animated: true, completion: nil)
            
        }
    }
}
