//
//  VideosRemoteData.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation
import Alamofire

class VideosRemoteData {
    
    weak var delegate: RemoteDataDelegate?
    
    func fetchVideos(withGameId: Int) {
        
        let params = ["game_id": withGameId]
        let headers = ["Client-ID": Api.clientId]
        
        Alamofire.request(Api.Endpoint.videos.url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200...300)
            .responseData { [weak self] (request) in
                switch request.result {
                case .success:
                    guard let data = request.data else {
                        self?.delegate?.requestDidReceivedError(RemoteDataError.dataEmpty)
                        return
                    }
                    self?.delegate?.dataDidLoaded(data)
                default:
                    break
                }

        }
    }
}
