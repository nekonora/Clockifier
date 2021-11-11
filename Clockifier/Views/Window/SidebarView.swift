//
//  SidebarView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct SidebarView: View {
    
    // MARK: - Properties
    @State private var isDefaultItemActive = true

    // MARK: - Body
    var body: some View {
        List {
            NavigationLink(destination: TimelineView(), isActive: $isDefaultItemActive) {
                Label("Console", systemImage: "message")
            }
            NavigationLink(destination: EmptyView()) {
                Label("Sent", systemImage: "paperplane")
            }
        }
        .listStyle(SidebarListStyle())
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar) {
                    Image(systemName: "sidebar.left")
                        .help("Toggle Sidebar")
                }
            }
        }
    }
    
    // MARK: - Methods
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
