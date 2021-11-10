//
//  TimeEntry.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

struct TimeEntry: Codable, Hashable, Identifiable {
    
    let id: String
    let projectId: String
    
    private let timeInterval: TimeInterval
}

extension TimeEntry {
    
    var clientName: String {
        ProjectsManager.shared
            .projects
            .first { $0.id == self.projectId }?
            .clientName ?? ""
    }
    
    var projectName: String {
        ProjectsManager.shared
            .projects
            .first { $0.id == self.projectId }?
            .name ?? ""
    }
    
    var duration: String {
        guard let start = startDate, let end = endDate else { return "N/A" }
        let diff = Calendar.current.dateComponents([.hour, .minute], from: start, to: end)
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
    
    var startDate: Date? {
        DateFormatter.iso8601Full.date(from: timeInterval.start)
    }
    
    var endDate: Date? {
        DateFormatter.iso8601Full.date(from: timeInterval.end)
    }
}

struct TimeInterval: Codable, Hashable {
    
    let start: String
    let end: String
    let duration: String
}
