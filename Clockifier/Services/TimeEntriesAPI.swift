//
//  TimeEntryNetwork.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class TimeEntriesAPI: NetworkHandler {
    
    // MARK: - Properties
    
    var manager: NetworkManager = NetworkManager.shared
    
    var timeEntries = [TimeEntry]()
    
    private let timeEntriesEndpoint  = "workspaces/:workspaceId/user/:userId/time-entries"
    private let newTimeEntryEndpoint = "workspaces/:workspaceId/time-entries"
    
    // MARK: - Instance
    
    static let shared = TimeEntriesAPI()
    
    // MARK: - Requests
    
    func getTimeEntries(for userId: String,
                        in workspaceId: String) -> AnyPublisher<[TimeEntry], Error> {
        let endPoint = timeEntriesEndpoint
            .replacingOccurrences(of: ":workspaceId", with: workspaceId)
            .replacingOccurrences(of: ":userId", with: userId)
        
        DevLogManager.shared.logMessage(type: .api, message: "time entries request")
        return manager
            .request(endPoint, method: .get)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func postNewTimeEntry(for projectId: String,
                          in workspaceId: String,
                          from start: String,
                          to end: String) -> AnyPublisher<TimeEntry, Error> {
        let endPoint = newTimeEntryEndpoint
            .replacingOccurrences(of: ":workspaceId", with: workspaceId)
        
        DevLogManager.shared.logMessage(type: .api, message: "new time entry post")
        return manager
            .request(endPoint, method: .post)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
