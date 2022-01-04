//
//  Services.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 04/01/22.
//  Copyright © 2022 Filippo Zaffoni. All rights reserved.
//

import Foundation

enum Services {
    case clockify, harvest
    
    var baseURL: URL {
        switch self {
        case .clockify: return URL(staticString: Constants.API.clockifyBaseUrl)
        case .harvest: return URL(staticString: Constants.API.harvestBaseUrl)
        }
    }
}


//        if signed {
//            switch service {
//            case .clockify:
//                _request.setValue(AppSecureKeys.clockifyAppToken, forHTTPHeaderField: "X-Api-Key")
//            case .harvest:
//                #warning("TODO: handle harvest signing")
//                _request.setValue(AppSecureKeys.harvestToken, forHTTPHeaderField: "")
//            }
//        }
