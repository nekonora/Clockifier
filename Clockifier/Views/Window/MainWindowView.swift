//
//  MainWindowView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct MainWindowView: View {
    
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            SidebarView()
            Text("No Sidebar Selection")
            Text("No Message Selection")
        }
    }
    
    
}
