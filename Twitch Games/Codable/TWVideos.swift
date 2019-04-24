//
//  TWVideos.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation

struct TWVideos: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let url, embedURL: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case embedURL = "embed_url"
    }
}
