//
//  NetworkHelper.swift
//  ButterChat
//
//  Created by Steven Shang on 1/20/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import Foundation
import SwiftSocket

class NetworkHelper {

    final let IP_ADDRESS = "68.234.145.223"
    final let PORT: Int32 = 8001

//    1. -s [sender name] [password] [message] //Sending message
//    2. -l //List registered users
//    4. -n [user name] [password] // Create new user
//    5. -c [language] // Check for any messages
    
    // step: createNewUser
    // step: list registered users
    // step: start listenning to conversation
    
    private var client: TCPClient
    
    init() {
        client = TCPClient(address: IP_ADDRESS, port: PORT)
    }
    
    // call openConnection when init ChatViewController
    // call closeConnection when exit ChatViewController
    
    func openConnection() -> Bool {
        
        switch client.connect(timeout: 1) {
        case .success:
            print("connection opened")
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }
    
    func closeConnection() {
        print("connection closed")
        client.close()
    }
    
    func createNewUser(username: String, password: String) -> Bool {
        
        switch client.send(string: "-n \(username) \(password)") {
        case .success:
            guard let data = client.read(1024*10) else {
                return false
            }
            guard let response = String(bytes: data, encoding: .utf8) else {
                return false
            }
            print(response)
            return true
        case .failure(let error):
            print(error)
            return false
        }
     }
    
    func getUsers(handler: ([String]) -> Void) {
        
        switch client.send(string: "-l") {
        case .success:
            guard let data = client.read(1024*10) else {
                return
            }
            if let response = String(bytes: data, encoding: .utf8) {
                let names = response.components(separatedBy: " ")
                print(names)
                handler(names)
            }
        case .failure(let error):
            print(error)
            return
        }
    }
    
    func getMessage(langauge: String, handler: (Bool, [(String, String)]?) -> Void) {
        
        switch client.send(string: "-c \(langauge)") {
        case .success:
            guard let data = client.read(1024*10) else {
                handler(false, nil)
                return
            }
            guard let response = String(bytes: data, encoding: .utf8) else {
                handler(false, nil)
                return
            }
            print(response)
            
            let messages: [(String,String)]? = []
            
            // parse messages
            
            handler(true, messages)
            
        case .failure(let error):
            print(error)
            handler(false, nil)
        }
    }
    
    func sendMessage(username: String, password: String, message: String) -> Bool {
        switch client.send(string: "-s \(username) \(password) \(message)") {
        case .success:
            guard let data = client.read(1024*10) else {
                return false
            }
            guard let response = String(bytes: data, encoding: .utf8) else {
                return false
            }
            print(response)
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }
    
}

extension NetworkHelper {
    
    static func sendHTTPRequest(targ: String) {
        let url = URL(string: targ)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else {
                print("No data")
                return
            }
            
            let response = String(data: data, encoding: .utf8) ?? ""
            print(response)
            
        }
        task.resume()
    }
}
