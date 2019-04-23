//
//  TWGames.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation

struct TWGames: Codable {
    let total: Int
    let links: TWGamesLinks
    let top: [TWTop]
    
    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case links = "_links"
        case top
    }
}

struct TWGamesLinks: Codable {
    let linksSelf, next: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next
    }
}

struct TWTop: Codable {
    let game: TWGame
    let viewers, channels: Int
}

struct TWGame: Codable {
    let name: String
    let popularity, id, giantbombID: Int
    let box, logo: TWBox
    let links: TWGameLinks
    let localizedName, locale: String
    
    enum CodingKeys: String, CodingKey {
        case name, popularity
        case id = "_id"
        case giantbombID = "giantbomb_id"
        case box, logo
        case links = "_links"
        case localizedName = "localized_name"
        case locale
    }
}

struct TWBox: Codable {
    let large, medium, small: String
    let template: String
}

struct TWGameLinks: Codable {
}
