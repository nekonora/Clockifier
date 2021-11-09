//
//  TimeEntryNetwork.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

final class TimeEntriesAPI: NetworkHandler {
    
    enum TimeEntriesError: Error {
        case failedEncoding
    }
    
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
    
    func postNewTimeEntry(_ entry: NewTimeEntry,
                          in workspaceId: String) -> AnyPublisher<TimeEntry, Error> {
        let endPoint = newTimeEntryEndpoint
            .replacingOccurrences(of: ":workspaceId", with: workspaceId)
        
        if
            let jsonData = try? JSONEncoder().encode(entry),
            let jsonString = String(data: jsonData, encoding: .utf8) {
            DevLogManager.shared.logMessage(type: .api, message: "new time entry post")
            
            return manager
                .request(endPoint, method: .post, body: jsonString)
                .map(\.value)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TimeEntriesError.failedEncoding).eraseToAnyPublisher()
        }
    }
}
