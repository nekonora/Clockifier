//
//  Collection+.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

extension Collection {
    
    var hasSomething: Bool { !isEmpty }
    
    subscript(safe index: Index) -> Element? { indices.contains(index) ? self[index] : nil }
}
