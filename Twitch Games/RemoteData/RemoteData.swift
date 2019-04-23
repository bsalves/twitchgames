//
//  RemoteData.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation

enum RemoteDataError: Error {
    case dataEmpty, notFound, timeout, serverError
}

protocol RemoteDataDelegate: class {
    func dataDidLoaded(_ data: Data)
    func requestDidReceivedError(_ error: Error)
}
