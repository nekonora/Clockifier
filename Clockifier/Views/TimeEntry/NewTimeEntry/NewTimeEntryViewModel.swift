//
//  NewTimeEntryViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

class NewTimeEntryViewModel: ObservableObject {
    
    // MARK: - Types
    
    enum TimeBound { case start, end }
    
    // MARK: - Properties
    
    private var cancellables = [AnyCancellable]()
    
    @Published var selectedProject: Project?
    
    @Published var selectedDate     = Date()
    @Published var selectedFromTime = Date()
    @Published var selectedToTime   = Date()
    
    @Published var description      = String()
    @Published var durationDesc     = String()
    
    private let cal = Calendar.current
    
    var startDate = Date() { didSet { durationDesc = duration } }
    var endDate   = Date() { didSet { durationDesc = duration } }
    
    // MARK: - Lifecycle
    
    init() {
        $selectedDate
            .sink { self.updateDate(from: $0) }
            .store(in: &cancellables)
        
        $selectedFromTime
            .sink { self.updateTime(.start, from: $0) }
            .store(in: &cancellables)
        
        $selectedToTime
            .sink { self.updateTime(.end, from: $0) }
            .store(in: &cancellables)
        
        selectedFromTime = defaultDate(for: .start)
        selectedToTime   = defaultDate(for: .end)
    }
    
    // MARK: - Requests
    
    func addNewTimeEntry(for projectId: String) {
//        TimeEntriesAPI.shared
//            .postNewTimeEntry(for: projectId)
//            .sink(receiveCompletion: { _ in
//
//            }, receiveValue: { _ in
//
//            })
//            .store(in: &cancellables)
    }
}

extension NewTimeEntryViewModel {
    
    enum Strings {
        static let quickEntryTitle = "Quick Entry"
        static let formDay         = "Day:"
        static let formFromHour    = "From:"
        static let formToHour      = "To:"
        static let formProject     = "Project:"
        
        static let addEntryButton  = "Add entry"
    }
}

private extension NewTimeEntryViewModel {
    
    func updateDate(from date: Date) {
        let startHour   = cal.component(.hour, from: startDate)
        let startMinute = cal.component(.minute, from: startDate)
        
        let endHour   = cal.component(.hour, from: endDate)
        let endMinute = cal.component(.minute, from: endDate)
        
        let updatedStartDate = cal.date(bySettingHour: startHour,
                                        minute: startMinute,
                                        second: 0,
                                        of: date)
        
        let updatedEndDate = cal.date(bySettingHour: endHour,
                                      minute: endMinute,
                                      second: 0,
                                      of: date)
        
        if let updatedStartDate = updatedStartDate, let updatedEndDate = updatedEndDate {
            startDate = updatedStartDate
            endDate   = updatedEndDate
        }
    }
    
    func updateTime(_ bound: TimeBound, from date: Date) {
        let hours   = cal.component(.hour, from: date)
        let minutes = cal.component(.minute, from: date)
        
        let updatedDate = cal.date(bySettingHour: hours,
                                   minute: minutes,
                                   second: 0,
                                   of: selectedDate)
        
        if let updatedDate = updatedDate {
            switch bound {
            case .start: startDate = updatedDate
            case .end:   endDate   = updatedDate
            }
        }
    }
    
    func defaultDate(for bound: TimeBound) -> Date {
        let hour: Int = {
            switch bound {
            case .start: return 9
            case .end:   return 17
            }
        }()
        
        let date = cal.date(bySettingHour: hour,
                            minute: 0,
                            second: 0,
                            of: selectedDate)
        
        return date ?? Date()
    }
    
    var duration: String {
        let diff = Calendar.current.dateComponents([.hour, .minute], from: startDate, to: endDate)
        var duration = ""
        
        if let hours = diff.hour {
            duration += String(format: "%02d", hours)
        }
        if let minutes = diff.minute {
            duration += ":"
            duration += String(format: "%02d", minutes)
        }
        
        duration += "h"
        return duration
    }
}
