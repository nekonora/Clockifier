//
//  Date+.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

extension Date {
    
    var formattedEntry: String {
        let days = Calendar.current.weekdaySymbols
        return """
        \(days[self.get(.weekday) - 1])
        \(self.get(.day))/\(self.get(.month))/\(self.get(.year))
        """
    }
    
    private func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        calendar.dateComponents(Set(components), from: self)
    }
    
    private func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        calendar.component(component, from: self)
    }
}
