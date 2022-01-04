//
//  TimeEntryNetwork.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation
import NetworkManager

protocol TimeEntriesAPIProvider: NetworkHandler {
    func getClockifyTimeEntries(for userId: String, in workspaceId: String) async throws -> [TimeEntry]
    func postClockifyNewTimeEntry(_ entry: ClockifyNewTimeEntry, in workspaceId: String) async throws
}

final class TimeEntriesAPI: TimeEntriesAPIProvider {
    
    enum Endpoint {
        static let clockifyTimeEntries = "workspaces/:workspaceId/user/:userId/time-entries"
        static let clockifyNewTimeEntry = "workspaces/:workspaceId/time-entries"
    }
    
    // MARK: - Requests
    func getClockifyTimeEntries(for userId: String, in workspaceId: String) async throws -> [TimeEntry] {
        let endPoint = Endpoint.clockifyTimeEntries
            .replacingOccurrences(of: ":workspaceId", with: workspaceId)
            .replacingOccurrences(of: ":userId", with: userId)
        
        return try await manager.request(baseURL: Service.clockify.baseURL,
                                         endpoint: endPoint,
                                         method: .get)
    }
    
    func postClockifyNewTimeEntry(_ entry: ClockifyNewTimeEntry, in workspaceId: String) async throws {
        let endpoint = Endpoint.clockifyNewTimeEntry
            .replacingOccurrences(of: ":workspaceId", with: workspaceId)
        let params = mapClockifyNewTimeEntry(entry)
        
        return try await manager.request(baseURL: Service.clockify.baseURL,
                                         endpoint: endpoint,
                                         method: .post,
                                         parameters: params,
                                         encoding: .json)
    }
}

// MARK: - Internals
private extension TimeEntriesAPI {
    
    func mapClockifyNewTimeEntry(_ entry: ClockifyNewTimeEntry) -> NetworkParameters {
        [
            "start": entry.start,
            "end": entry.end,
            "description": entry.description,
            "projectId": entry.projectId,
            "taskId": entry.taskId,
            "billable": entry.billable,
            "tagsIds": entry.tagsIds
        ]
    }
}
