//
//  ContentViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    
    // MARK: - Properties

    private var cancellables = [AnyCancellable]()
    
    private var authManager   = AuthManager.shared
    private var windowManager = WindowManager.shared
    
    // MARK: - Methods
    
    func logOut() {
        KeychainManager.shared.reset()
        authManager.logOut()
        windowManager.resizePopOver(to: .login)
    }
}

extension ContentViewModel {
    
    enum Strings {
        static let appTitle = "Clockifier"
        static let settings = "Log out"
        
        static let userPlaceholderName = "User"
    }
}
