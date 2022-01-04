//
//  API.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 10/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import Foundation

final class API {
    static let user: UserAPIProvider = UserAPI()
    static let timeEntries: TimeEntriesAPIProvider = TimeEntriesAPI()
    static let projects: ProjectsAPIProvider = ProjectsAPI()
}

enum Service {
    case clockify, harvest
    
    var baseURL: URL {
        switch self {
        case .clockify: return URL(staticString: Constants.API.clockifyBaseUrl)
        case .harvest: return URL(staticString: Constants.API.harvestBaseUrl)
        }
    }
}
