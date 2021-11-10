//
//  SettingsViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    private let authManager: AuthManager
    private let windowManager: WindowManager
    
    // MARK: - Init
    init(authManager: AuthManager = .shared, windowManager: WindowManager = .shared) {
        self.authManager = authManager
        self.windowManager = windowManager
    }
    
    // MARK: - Methods
    func logOut() {
        authManager.logOut()
        windowManager.resizePopOver(to: .login)
    }
    
    func quitApp() {
        windowManager.quitApp()
    }
}

extension SettingsViewModel {
    
    enum Strings {
        static let settingsTitle = "Settings"
        
        static let logOutButton = "Log out"
        static let quitAppButton = "Quit"
    }
}
