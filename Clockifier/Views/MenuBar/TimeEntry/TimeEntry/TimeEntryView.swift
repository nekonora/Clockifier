//
//  TimeEntry.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct TimeEntryView: View {
    
    // MARK: - Properties
    
    var timeEntry: TimeEntry
    
    // MARK: - View
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(timeEntry.projectName)
                        .font(.system(Font.TextStyle.headline, design: .rounded))
                        .fontWeight(.bold)
                    
                    Text(timeEntry.clientName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(width: 180, height: 50, alignment: .leading)
                
                VStack(alignment: .center) {
                    Text(timeEntry.startDate?.formattedEntry ?? "")
                        .font(.caption)
                }
                .frame(width: 120, height: 50, alignment: .leading)
                
                Text(timeEntry.duration)
                    .font(.system(Font.TextStyle.subheadline, design: .rounded))
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 100, height: 26, alignment: .center)
                    .background(Color(.controlAccentColor))
                    .cornerRadius(13)
            }
            
            Divider()
        }
        
    }
}
