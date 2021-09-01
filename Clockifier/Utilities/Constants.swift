//
//  Constants.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

enum Constants {
    
    enum App {
        static let keychainBundle = Bundle.main.object(forInfoDictionaryKey: "keychainBundle") as! String
    }
    
    enum API {
        static let clockifyBaseUrl = Bundle.main.object(forInfoDictionaryKey: "clockifyBaseUrl") as! StaticString
        static let harvestBaseUrl = Bundle.main.object(forInfoDictionaryKey: "harvestBaseUrl") as! StaticString
    }
}
