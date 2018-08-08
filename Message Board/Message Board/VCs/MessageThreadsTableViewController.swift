//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Samantha Gatt on 8/8/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        

        return cell
    }
    
    
    // MARK: - Actions
    
    @IBAction func submitMessageThread(_ sender: Any) {
    }
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    // MARK: - Properties
    
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
