//
//  GamesViewModel.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation
import Reachability

protocol GamesViewModelDelegate: class {
    func encodingDataReceivedError(_ error: Error?)
    func gamesDidLoad(_ games: [GameModel])
    func connectionFails()
}

class GamesViewModel {
    
    // MARK: Local properties
    
    var topGamesRemoteData = TopGamesRemoteData()
    lazy var gamesLocalData = GamesLocalData()
    weak private var delegate: GamesViewModelDelegate?
    
    // MARK: Private properties
    
    private var games = [GameModel]()
    
    // MARK: Constructor
    
    init(delegate: GamesViewModelDelegate) {
        self.delegate = delegate
        topGamesRemoteData.delegate = self
        self.gamesFromTwitch()
    }
    
    func refreshGames() {
        self.gamesFromTwitch()
    }
    
    // MARK: Private methods
    
    private func gamesFromTwitch() {
        if Connectivity.isConnectedToInternet() {
            topGamesRemoteData.fetch()
            return
        }
        
        let gamesLocal = gamesLocalData.loadAllData()
        if gamesLocal.count > 0 {
            self.delegate?.gamesDidLoad(gamesLocal)
            return
        }
        self.delegate?.connectionFails()
    }
}

extension GamesViewModel: RemoteDataDelegate {
    func dataDidLoaded(_ data: Data) {
        do {
            let games = try JSONDecoder().decode(TWGames.self, from: data)
            self.games = []
            games.top.forEach { [unowned self] (game) in
                self.games.append(GameModel(gameId: game.game.id, gameName: game.game.name, imageUrl: game.game.box.large, channels: String(describing: game.viewers), viewers: String(describing: game.channels)))
            }
            // save cache of games
            self.gamesLocalData.deleteData()
            self.gamesLocalData.saveData(self.games)
            self.delegate?.gamesDidLoad(self.games)
        } catch let error {
            self.delegate?.encodingDataReceivedError(error)
        }
    }
    
    func requestDidReceivedError(_ error: Error) {
        self.delegate?.encodingDataReceivedError(error)
    }
}
