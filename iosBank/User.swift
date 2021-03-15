//
//  User.swift
//  iosBank
//
//  Created by Sumit Desai on 12/25/1399 AP.
//

import Foundation

class User{
    var name: String
    var email: String
    var password: String
    var question: String
    
    init(name: String, email: String, password: String, question: String) {
        self.name = name
        self.email = email
        self.password = password
        self.question = question
    }
}
