//
//  TimeEntryViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class TimeEntriesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private var cancellables = [AnyCancellable]()
    
    @Published var timeEntries = [TimeEntry]()
    
    // MARK: - Lifecycle
    
    init() {
        guard let user = AuthManager.shared.currentUser else { return }
        
        fetchTimeEntries(for: user.id, in: user.activeWorkspace)
    }
    
    // MARK: - Methods
    
    func fetchTimeEntries(for userId: String, in workspaceId: String) {
        TimeEntriesAPI.shared
            .getTimeEntries(for: userId, in: workspaceId)
            .sink(receiveCompletion: {
                DevLogManager.shared.logMessage(type: .api, message: "time entries request status: \($0)")
            }, receiveValue: {
                self.timeEntries = $0
            })
            .store(in: &cancellables)
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
