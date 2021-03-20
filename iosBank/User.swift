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
    var balance: Double
    
    init(){
        self.name = ""
        self.email = ""
        self.password = ""
        self.question = ""
        self.balance = 0.0
    }
    
    init(name: String, email: String, password: String, question: String, balance: Double) {
        self.name = name
        self.email = email
        self.password = password
        self.question = question
        self.balance = balance
    }
}
