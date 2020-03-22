//
//  ProjectsAPI.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class ProjectsAPI: NetworkHandler {
    
    // MARK: - Properties
    
    var manager: NetworkManager = NetworkManager.shared
    
    private let projectsEndpoint = "workspaces/:workspaceId/projects"
    
    // MARK: - Instance
    
    static let shared = ProjectsAPI()
    
    // MARK: - Requests
    
    func getProjects(for workspaceId: String) -> AnyPublisher<[Project], Error> {
        let endPoint = projectsEndpoint.replacingOccurrences(of: ":workspaceId", with: workspaceId)
        DevLogManager.shared.logMessage(type: .api, message: "projects request")
        return manager
            .request(endPoint, method: .get)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
