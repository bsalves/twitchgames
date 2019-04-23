//
//  TWVideos.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation

struct TWVideos: Codable {
    let data: [TWData]
    let pagination: Pagination
}

struct TWData: Codable {
    let id, userID, userName, title: String
    let description: String
    let createdAt, publishedAt: Date
    let url: String
    let thumbnailURL, viewable: String
    let viewCount: Int
    let language, type, duration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case userName = "user_name"
        case title, description
        case createdAt = "created_at"
        case publishedAt = "published_at"
        case url
        case thumbnailURL = "thumbnail_url"
        case viewable
        case viewCount = "view_count"
        case language, type, duration
    }
}

struct Pagination: Codable {
    let cursor: String
}
