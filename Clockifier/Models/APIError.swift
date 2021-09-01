//
//  APIError.swift
//  APIError
//
//  Created by Filippo Zaffoni on 01/09/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import Foundation

enum APIError: LocalizedError {
    enum NetworkingError {
        case invalidResponse
        case wrongStatusCode(statusCode: Int, message: String)
        case invalidJSONData(data: Data)
    }
    
    enum AuthError {
        case tokenFetch
    }
    
    enum GamesError {
        case couldNotFetchGame(message: String)
        case couldNotFetchGames(message: String)
    }
    
    case networking(error: NetworkingError)
    case auth(error: AuthError)
    case games(error: GamesError)
    case generic(message: String)
    
    var errorDescription: String? {
        switch self {
        case .networking(let error):
            switch error {
            case .invalidResponse:
                return "Invalid response"
            case .wrongStatusCode(let statusCode, let message):
                return "Error - status code: \(statusCode), message:\n\(message)"
            case .invalidJSONData(let data):
                if let dataString = String(data: data, encoding: .utf8) {
                    return "Could not create JSON from data: \(dataString)"
                } else {
                    return "Could not create JSON from data"
                }
            }
        case .auth(let error):
            switch error {
            case .tokenFetch:
                return "Could not parse token"
            }
        case .games(let error):
            switch error {
            case .couldNotFetchGame(let message), .couldNotFetchGames(let message):
                return message
            }
        case .generic(let message):
            return message
        }
    }
}
