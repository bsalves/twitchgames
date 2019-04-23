//
//  TopGamesRemoteData.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation
import Alamofire

class TopGamesRemoteData {
    
    weak var delegate: RemoteDataDelegate?
    
    func fetch() {
        
        // TODO: Store API Endpoint on info.plist
        
        let params = ["limit": 10]
        let headers = ["Client-ID": "i956f46goi35c3xc054c948shm3snl"]
        
        Alamofire.request("https://api.twitch.tv/kraken/games/top", method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
