//
//  UserDefaults+.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Keys

    private struct Keys {
        
        static let lastUsedProjectId = "lastUsedProject"
    }

    // MARK: - Properties

    static var lastUsedProjectId: String? {
        get { UserDefaults.standard.string(forKey: Keys.lastUsedProjectId) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.lastUsedProjectId)
            UserDefaults.standard.synchronize()
        }
    }
}
