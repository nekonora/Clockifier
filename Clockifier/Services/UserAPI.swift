//
//  LoginNetwork.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class UserAPI: NetworkHandler {
    
    // MARK: - Properties
    
    var manager: NetworkManager = NetworkManager.shared
    
    private let userEndpoint = "user"
    
    // MARK: - Instance
    
    static let shared = UserAPI()
    
    // MARK: - Requests
    
    func getUser() -> AnyPublisher<User, Error> {
        DevLogManager.shared.logMessage(type: .api, message: "user request")
        return manager
            .request(userEndpoint, method: .get)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
