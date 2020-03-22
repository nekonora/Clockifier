//
//  Project.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

struct Project: Codable, Hashable, Identifiable {
    
    let id: String
    let name: String
    let clientName: String
}
