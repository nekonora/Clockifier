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
    
}

extension ContentViewModel {
    
    enum Strings {
        static let appTitle = "Clockifier"
        static let settings = "Log out"
        
        static let userPlaceholderName = "User"
    }
}
