//
//  User.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 16/01/22.
//

import Foundation

// MARK: - User
struct User: Codable {
    let code: Int
    let message: String
    let data: UserData?
    
    enum CodingKeys: String, CodingKey {
        case code, message, data
    }
}

// MARK: - DataClass
struct UserData: Codable {
    let dataID: Int
    let name, email, token: String
    
    enum CodingKeys: String, CodingKey {
        case dataID = "Id"
        case name = "Name"
        case email = "Email"
        case token = "Token"
    }
}

/*
 {
 "email":"johnios9952@gmail.com",
 "password":123456
 }
 
 output
 {
 "code": 0,
 "message": "success",
 "data": {
 "Id": 15562,
 "Name": "developer",
 "Email": "johnios9952@gmail.com",
 "Token": "445cc006-0834-45ca-a0a9-b1467fe829ec"
 }
 }
 */
