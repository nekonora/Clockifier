//
//  ClockifyNewTimeEntry.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 10/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import Foundation

struct ClockifyNewTimeEntry {
    
    let start: String
    let end: String

    let description: String
    let projectId: String
    
    var taskId = ""
    var billable = "true"
    var tagsIds = [String]()
}
