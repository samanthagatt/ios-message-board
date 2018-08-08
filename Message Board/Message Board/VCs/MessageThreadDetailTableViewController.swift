//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Samantha Gatt on 8/8/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let messageThread = messageThread else { fatalError("Error: messageThread is nil") }
        navigationItem.title = messageThread.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThread?.messages.sort { $0.timestamp < $1.timestamp }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    // MARK: Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messageThread = messageThread else { fatalError("Error: messageThread is nil") }
        return messageThread.messages.count
    }

    // MARK: Cell for row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        guard let messageThread = messageThread else { fatalError("Error: messageThread is nil") }
        let message = messageThread.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender

        return cell
    }
    
    
    // MARK: - Refresh
    
    

    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddMessageThread" {
            let destination = segue.destination as! MessageDetailViewController
            destination.messageThread = messageThread
            destination.messageThreadController = messageThreadController
        }
    }

}
