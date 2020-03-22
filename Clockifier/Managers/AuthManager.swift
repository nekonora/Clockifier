//
//  AuthManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

class AuthManager: ObservableObject {
    
    // MARK: - Properties
    
    static let shared = AuthManager()
    
    @Published var currentUser: User?
    
    private var loginVM: LoginViewModel?
    
    // MARK: - Lifecycle
    
    init() { logIn() }
    
    // MARK: - Methods
    
    func logIn() {
        guard let apiKey = KeychainManager.shared.apiKey else { return }
        loginVM = LoginViewModel()
        loginVM?.login(apiKey)
    }
    
    func logOut() { currentUser = nil }
}
