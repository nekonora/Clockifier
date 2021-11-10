//
//  LoginViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

final class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let windowManager: WindowManager
    private let userDataSource: UserAPIProvider
    private let projectsDataSource: ProjectsAPIProvider
    private let projectsManager: ProjectsManager
    private let authManager: AuthManager
    
    @Published var isLoading = false
    @Published var loginError = false
    @Published var clockifyApiKey = ""
    
    // MARK: - Init
    init(userDataSource: UserAPIProvider = API.user,
         projectsDataSource: ProjectsAPIProvider = API.projects,
         projectsManager: ProjectsManager = .shared,
         windowManager: WindowManager = .shared,
         authManager: AuthManager = .shared) {
        self.userDataSource = userDataSource
        self.projectsDataSource = projectsDataSource
        self.projectsManager = projectsManager
        self.windowManager = windowManager
        self.authManager = authManager
    }
    
    // MARK: - Methods
    func didTapLogin() {
        guard !clockifyApiKey.isEmpty else { return }
        
        Task {
            await clockifyLogin(clockifyApiKey)
        }
    }
    
    func quitApp() {
        windowManager.quitApp()
    }
}

private extension LoginViewModel {
    
    func clockifyLogin(_ apiKey: String) async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            let user = try await userDataSource.getClockifyUser()
            let projects = try await projectsDataSource.getClockifyProjects(for: user.activeWorkspace)
            
            authManager.currentUser = user
            projectsManager.projects = projects
            
            AppSecureKeys.clockifyAppToken = apiKey
            windowManager.resizePopOver(to: .allVisible)
        } catch {
            authManager.logOut()
            loginError = true
        }
    }
}

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
