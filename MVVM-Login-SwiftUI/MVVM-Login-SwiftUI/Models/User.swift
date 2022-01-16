//
//  User.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 16/01/22.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: String
    let code: Int
    let message: String
    let data: UserData?

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case code, message, data
    }
}

// MARK: - DataClass
struct UserData: Codable {
    let id: String
    let dataID: Int
    let name, email, token: String

    enum CodingKeys: String, CodingKey {
        case id = "$id"
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
 */
