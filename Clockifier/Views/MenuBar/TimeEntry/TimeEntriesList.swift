//
//  TimeEntriesList.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct TimeEntriesList: View {
    
    @State var timeEntries: [TimeEntry]
    var onEndReached: (() -> Void)? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(zip(timeEntries.indices, timeEntries)), id: \.1) { index, entry in
                    TimeEntryView(timeEntry: entry)
                    .onAppear() { valuateEndReached(index) }
                }
            }
        }
    }
    
    private func valuateEndReached(_ indexShown: Int) {
        guard indexShown > (timeEntries.count - 2) else { return }
        onEndReached?()
    }
}
