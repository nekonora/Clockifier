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
    
    private var windowManager = WindowManager.shared
    
    @Published var settingsShown = false
    
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
