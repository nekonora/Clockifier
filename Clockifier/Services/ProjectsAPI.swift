//
//  ProjectsAPI.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation
import NetworkManager

protocol ProjectsAPIProvider: NetworkHandler {
    func getClockifyProjects(for workspaceId: String) async throws -> [Project]
}

final class ProjectsAPI: ProjectsAPIProvider {
    
    enum Endpoint {
        static let clockifyProjects = "workspaces/:workspaceId/projects"
    }
    
    // MARK: - Requests
    func getClockifyProjects(for workspaceId: String) async throws -> [Project] {
        let endpoint = Endpoint.clockifyProjects
            .replacingOccurrences(of: ":workspaceId", with: workspaceId)
        
        return try await manager.request(baseURL: Service.clockify.baseURL,
                                         endpoint: endpoint,
                                         method: .get)
    }
}
