//
//  TimelineView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct TimelineView: View {
    
    // MARK: - Body
    var body: some View {
        List(Array(0...100).map(String.init), id: \.self) { message in
            NavigationLink(destination: EmptyView()) {
                Text(message)
            }
        }
        .navigationTitle("Inbox")
        .toolbar {
            Button(action: { /* Open filters */ }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
            }
        }
    }
}
