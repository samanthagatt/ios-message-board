//
//  MessageThread.swift
//  Message Board
//
//  Created by Samantha Gatt on 8/8/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    // MARK: - Properties
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    // MARK: - Message struct
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    // MARK: - Initializer
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    // MARK: - Conform to equatable
    
    func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return
            lhs.title == rhs.title &&
                lhs.identifier == rhs.identifier &&
                lhs.messages == rhs.messages
    }
}
