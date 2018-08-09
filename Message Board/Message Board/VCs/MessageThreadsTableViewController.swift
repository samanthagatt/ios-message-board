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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetch()
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title

        return cell
    }
    
    
    // MARK: - Functions
    
    func fetch() {
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func refresh() {
        fetch()
    }
    
    
    // MARK: - Actions
    
    @IBAction func submitMessageThread(_ sender: Any) {
        guard let title = textField.text else { return }
        messageThreadController.createMessageThread(title: title) { (error) in
            if let error = error {
                NSLog("Error creating new message thread: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    // MARK: - Properties
    
    let messageThreadController = MessageThreadController()
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageThreadDetails" {
            let destination = segue.destination as! MessageThreadDetailTableViewController
            
            destination.messageThreadController = messageThreadController
            
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let messageThread = messageThreadController.messageThreads[index]
            destination.messageThread = messageThread
        }
    }
}
