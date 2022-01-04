//
//  LoginNetwork.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation
import NetworkManager

protocol UserAPIProvider: NetworkHandler {
    func getClockifyUser() async throws -> User
}

final class UserAPI: UserAPIProvider {
    
    enum Endpoint {
        static let clockifyUser = "user"
    }
    
    // MARK: - Requests
    func getClockifyUser() async throws -> User {
        try await manager.request(baseURL: Service.clockify.baseURL,
                                  endpoint: Endpoint.clockifyUser,
                                  method: .get)
    }
}
