//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/11/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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

}
