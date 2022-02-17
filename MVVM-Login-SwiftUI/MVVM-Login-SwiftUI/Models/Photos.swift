//
//  Photos.swift
//  MVVM-Login-SwiftUI
//
//  Created by Sachin Daingade on 17/02/22.
//

import Foundation

struct Photos: Codable,Identifiable {
    let albumID: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
