//
//  TimeEntryViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

final class TimeEntriesViewModel: ObservableObject {
    
    // MARK: - Properties
    let timeEntriesDataSource: TimeEntriesAPIProvider
    
    @Published var timeEntries = [TimeEntry]()
    @Published var isLoading = false
    
    // MARK: - Init
    init(timeEntriesDataSource: TimeEntriesAPIProvider = API.timeEntries, authManager: AuthManager = .shared) {
        self.timeEntriesDataSource = timeEntriesDataSource
    }
    
    // MARK: - Methods
    func fetchTimeEntries(for userId: String, in workspaceId: String) async throws {
        defer { isLoading = false }
        isLoading = true
        
        do {
            timeEntries = try await timeEntriesDataSource.getClockifyTimeEntries(for: userId, in: workspaceId)
        } catch {
            #warning("TODO: handle error")
        }
    }
}

extension TimeEntriesViewModel {
    
    enum Strings {
        static let pastEntriesTitle = "Past entries"
        static let legendProject    = "Project"
        static let legendDate       = "Date"
        static let legendDuration   = "Duration"
    }
}
