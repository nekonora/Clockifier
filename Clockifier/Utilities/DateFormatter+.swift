//
//  DateFormatter+.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let iso8601Full: DateFormatter = {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar   = Calendar(identifier: .iso8601)
        formatter.timeZone   = Calendar.current.timeZone
        formatter.locale     = Locale.current
        return formatter
    }()
    
    static let iso8601FullUTC: DateFormatter = {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar   = Calendar(identifier: .iso8601)
        formatter.timeZone   =  TimeZone(identifier: "UTC")
        formatter.locale     = Locale.current
        return formatter
    }()
}
