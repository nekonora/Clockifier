//
//  ContentView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Cocoa
import SwiftUI

struct ContentView: View {
    
    // MARK: - Observables
    
    @EnvironmentObject var authManager: AuthManager
    
    @ObservedObject private var viewModel = ContentViewModel()
    
    // MARK: - View
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            if self.authManager.currentUser == nil {
                
                LoginView()
                
            } else {
                
                HStack(alignment: .center) {
                    Text(ContentViewModel.Strings.appTitle)
                        .font(.system(Font.TextStyle.headline, design: .rounded))
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(authManager.currentUser?.name ?? ContentViewModel.Strings.userPlaceholderName)
                        .font(.system(Font.TextStyle.footnote, design: .rounded))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                    
                    Spacer()
                    
                    Button(ContentViewModel.Strings.settings) {
                        KeychainManager.shared.reset()
                        self.authManager.logOut()
                    }
                }
                
                Divider()
                
                TimeEntriesView()
            }
            
        }.padding()
    }
}
