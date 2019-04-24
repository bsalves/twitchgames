//
//  GameDetailViewModel.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation

protocol GameDetailViewModelDelegate: class {
    func encodingDataReceivedError(_ error: Error?)
    func invalidUrl()
    func videoDidLoad(_ videoUrl: URL)
    func videosEmptyList()
}

class GameDetailViewModel {
    
    // MARK: Internal properties
    
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
    
    // MARK: Private properties
    
    private weak var delegate: GameDetailViewModelDelegate?
    private var game: GameModel
    private var videosRemoteData = VideosRemoteData()
    
    init(game: GameModel, withDelegate: GameDetailViewModelDelegate) {
        self.game = game
        self.delegate = withDelegate
        self.videosRemoteData.delegate = self
    }
    
    // MARK: Internal methods
    
    func loadVideo(gameId: Int) {
        videosRemoteData.fetchVideos(withGameId: gameId)
    }
}

extension GameDetailViewModel: RemoteDataDelegate {
    func dataDidLoaded(_ data: Data) {
        do {
            let videos = try JSONDecoder().decode(TWVideos.self, from: data)
            
            if videos.data.count > 0 {
                let random = Int(arc4random_uniform(UInt32(videos.data.count)))
                guard let videoUrl = URL(string: videos.data[random].embedURL) else {
                    delegate?.invalidUrl()
                    return
                }
                self.delegate?.videoDidLoad(videoUrl)
            } else {
                self.delegate?.videosEmptyList()
            }
            
        } catch let error {
            self.delegate?.encodingDataReceivedError(error)
        }
    }
    
    func requestDidReceivedError(_ error: Error) {
        self.delegate?.encodingDataReceivedError(error)
    }
}
