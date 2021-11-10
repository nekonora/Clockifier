//
//  AuthManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

final class AuthManager: ObservableObject {
    
    // MARK: - Properties
    static let shared = AuthManager()
    
    @Published var currentUser: User?
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func logOut() {
        AppSecureKeys.reset()
        AppPreferences.reset()
        currentUser = nil
    }
}
