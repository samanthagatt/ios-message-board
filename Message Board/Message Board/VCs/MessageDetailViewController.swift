//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Samantha Gatt on 8/8/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    // MARK: - Actions
    
    @IBAction func send(_ sender: Any) {
        guard let thisMessageThread = messageThread,
            let sender = textField.text,
            let text = textView.text else { return }
        
        messageThreadController?.createMessage(fromThread: thisMessageThread, text: text, sender: sender, completion: { (error) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    

    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
}
