//
//  NetworkHelper.swift
//  ButterChat
//
//  Created by Steven Shang on 1/20/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    func sendRequest() {
        let url = URL(string: "http://127.0.0.1:8000")
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
