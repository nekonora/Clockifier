//
//  WindowManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation
import AppKit

class WindowManager {
    
    // MARK: - Types
    
    enum PopOverSize {
        case login, onlyQuickEntry, onlyTimeEntries, allVisible
        
        var size: CGSize {
            switch self {
            case .login:           return CGSize(width: 340, height: 400)
            case .onlyQuickEntry:  return CGSize(width: 340, height: 600)
            case .onlyTimeEntries: return CGSize(width: 340, height: 600)
            case .allVisible:      return CGSize(width: 340, height: 600)
            }
        }
    }
    
    // MARK: - Properties
    
    static let shared = WindowManager()
    
    var popOver: NSPopover?
    
    // MARK: - Methods
    
    func resizePopOver(to size: PopOverSize) {
        popOver?.contentSize = size.size
    }
}
