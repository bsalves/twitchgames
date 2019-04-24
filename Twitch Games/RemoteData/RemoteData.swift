//
//  RemoteData.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation
import Alamofire

enum RemoteDataError: Error {
    case dataEmpty, notFound, timeout, serverError
}

protocol RemoteDataDelegate: class {
    func dataDidLoaded(_ data: Data)
    func requestDidReceivedError(_ error: Error)
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

struct Api {
    static var clientId: String {
        return Api.dictionary["TwitchClientId"] as? String ?? ""
    }
    
    private static var dictionary: NSDictionary {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else { return NSDictionary() }
        return NSDictionary(contentsOfFile: path) ?? NSDictionary()
    }
    
    enum Endpoint {
        case games, videos
        
        var url: String {
            let dictionary = Api.dictionary
            switch self {
            case .games:
                return dictionary["TopGamesEndpoint"] as? String ?? ""
            case .videos:
                return dictionary["VideosEndpoint"] as? String ?? ""
            }
        }
    }
}

