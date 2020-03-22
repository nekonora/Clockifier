//
//  ProjectsManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

class ProjectsManager {
    
    // MARK: - Properties
    
    static let shared = ProjectsManager()
    
    var projects = [Project]()
}
