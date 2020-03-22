//
//  SettingsViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class SettingsViewModel: ObservableObject {
    
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
    
    func quitApp() {
        windowManager.quitApp()
    }
}

extension SettingsViewModel {
    
    enum Strings {
        static let settingsTitle = "Settings"
        
        static let logOutButton  = "Log out"
        static let quitAppButton = "Quit"
    }
}
