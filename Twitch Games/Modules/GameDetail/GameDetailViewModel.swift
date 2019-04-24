//
//  GameDetailViewModel.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation

class GameDetailViewModel {
    
    var gameName: String {
        return game.gameName
    }
    
    var viewers: String {
        return game.viewers
    }
    
    var channels: String {
        return game.channels
    }
    
    var cover: String {
        return game.imageUrl
    }
    
    private var game: GameModel
    
    init(game: GameModel) {
        self.game = game
    }
}
