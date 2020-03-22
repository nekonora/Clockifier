//
//  LoginViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private var cancellables = [AnyCancellable]()
    
    @Published var loginError = false
    @Published var apiKey: String?
    
    // MARK: - Methods
    
    func login(_ apiKey: String) {
        KeychainManager.shared.apiKey = apiKey
        
        UserAPI.shared
            .getUser()
            .sink(receiveCompletion: {
                self.loginError               = true
                KeychainManager.shared.apiKey = nil
                DevLogManager.shared.logMessage(type: .api, message: "user request status: \($0)")
            }, receiveValue: {
                self.loginError = false
                self.fetchProjects(for: $0.activeWorkspace)
                AuthManager.shared.currentUser = $0
                
                WindowManager.shared.resizePopOver(to: .allVisible)
            })
            .store(in: &cancellables)
    }
    
    func fetchProjects(for workspaceId: String) {
        ProjectsAPI.shared
            .getProjects(for: workspaceId)
            .sink(receiveCompletion: {
                DevLogManager.shared.logMessage(type: .api, message: "projects request status: \($0)")
            }, receiveValue: {
                ProjectsManager.shared.projects = $0
            })
            .store(in: &cancellables)
    }
}

// MARK: - Constants

extension LoginViewModel {
    
    enum Strings {
        static let welcomTitle          = "Welcome to Clockifier!"
        static let welcomeSubtitle      = "Let's start loggin'"
        static let loginTips            = "To manage your Clockify account within the app, you need to authenticate using your personal API key, which can be generated in your profile settings page on the Clockify website."
        static let textfieldPlaceholder = "Enter your Clockify API key"
        static let loginButton          = "Add account"
        static let loginError           = "Authentication Error"
    }
}
