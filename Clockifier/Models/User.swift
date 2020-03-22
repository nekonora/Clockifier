//
//  User.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let id: String
    let name: String
    let email: String
    let profilePicture: String
    
    let activeWorkspace: String
}
