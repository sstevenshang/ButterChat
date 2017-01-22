//
//  User.swift
//  ButterChat
//
//  Created by Steven Shang on 1/21/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import Foundation

class User {
    
    var username: String!
    var password: String!
    var language: String!
    
    init(username: String, password: String, language: String) {
        self.username = username
        self.password = password
        self.language = language
    }
    
}
