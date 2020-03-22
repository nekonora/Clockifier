//
//  KeychainManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation
import KeychainSwift

class KeychainManager: ObservableObject {
    
    // MARK: - Properties
    
    static let shared = KeychainManager()
    
    @Published private var _apiKey: String?
    var apiKey: String? {
        get { keychain?.get(Constants.Keychain.apiKey) }
        set {
            guard let key = newValue else { return }
            self._apiKey = newValue
            keychain?.set(key, forKey: Constants.Keychain.apiKey)
        }
    }
    
    private let keychain: KeychainSwift?
    
    // MARK: - Lifecycle
    
    init() { keychain = KeychainSwift() }
    
    // MARK: - Methods
    
    func reset() {
        keychain?.delete(Constants.Keychain.apiKey)
    }
}
