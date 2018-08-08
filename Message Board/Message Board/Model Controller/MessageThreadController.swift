//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Samantha Gatt on 8/8/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class MessageThreadController {
    // MARK: - Properties
    var messageThreads: [MessageThread] = []
    
    // MARK: - baseURL
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    // MARK: - Create message thread method
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        // Creates the message thread
        let messageThread = MessageThread(title: title)
        
        // Creates the full url where our message thread data will be saved/stored
        let requestURL = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        // Creates the URLRequest and sets it's method (put)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        // Encodes messageThread into json data so it can be stored
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch  {
            NSLog("Error encoding new message thread into json data: \(error)")
            completion(error)
            return
        }
        
        // Data task - "PUT"'s the data at the given url
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error storing data on server: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()
    }
    
    // MARK: - Create message method
    func createMessage(fromThread thread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        // Creates the message
        let message = MessageThread.Message(text: text, sender: sender)
        
        // Creates the url using the thread's identifier
        let requestURL = MessageThreadController.baseURL
            .appendingPathComponent(thread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Error encoding new message into json data: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error storing data on server: \(error)")
                completion(error)
                return
            }
            
            thread.messages.append(message)
            completion(nil)
            
        }.resume()
    }
    
    // MARK: - Fetch message threads
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do {
                let messageThreadDictionaries = try JSONDecoder().decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.compactMap { $0.value }
                self.messageThreads = messageThreads.sorted { $0.title.lowercased() < $1.title.lowercased() }
                completion(nil)
            } catch {
                NSLog("Error decoding fetched data: \(error)")
                completion(error)
            }
        }.resume()
    }
}
