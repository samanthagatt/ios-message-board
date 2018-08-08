//
//  MessageThread.swift
//  Message Board
//
//  Created by Samantha Gatt on 8/8/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class MessageThread: Codable {
    // MARK: - Properties
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    // MARK: - Message struct
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date())
    }
    
    // MARK: - Initializer
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    // MARK: - Conform to equatable
    
    
}
