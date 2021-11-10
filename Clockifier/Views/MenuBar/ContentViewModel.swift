//
//  ContentViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

final class ContentViewModel: ObservableObject {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    let windowManager: WindowManager
    let authManager: AuthManager
    
    @Published var settingsShown = false
    @Published var user: User?
    
    // MARK: - Init
    init(authManager: AuthManager = .shared, windowManager: WindowManager = .shared) {
        self.authManager = authManager
        self.windowManager = windowManager
        
        authManager.$currentUser
            .sink { [weak self] in self?.user = $0 }
            .store(in: &cancellables)
    }
    
    // MARK: - Methods
    func toggleSettings() {
        settingsShown.toggle()
        windowManager.resizePopOver(to: settingsShown ? .withSettings : .allVisible)
    }
}

extension ContentViewModel {
    
    enum Strings {
        static let settings = "Log out"
        static let userPlaceholderName = "User"
    }
}
