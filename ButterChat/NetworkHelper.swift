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
    
    let username = "steven"
    let password = "password"
    
//    1. -s [sender name] [password] [message] //Sending message
//    2. -l //List registered users
//    4. -n [user name] [password] // Create new user
//    5. -c [language] // Check for any messages
    
    func createNewUser() {
        
        let client = TCPClient(address: IP_ADDRESS, port: PORT)
        switch client.connect(timeout: 10) {
        case .success:
            switch client.send(string: "-n \(username) \(password)") {
            case .success:
                guard let data = client.read(1024*10) else {
                    return
                }
                if let response = String(bytes: data, encoding: .utf8) {
                    print(response)
                }
            case .failure(let error):
                print(error)
            }
        case .failure(let error):
            print(error)
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
