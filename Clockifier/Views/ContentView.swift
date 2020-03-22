//
//  ContentView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Observables
    
    @EnvironmentObject var authManager: AuthManager
    
    @ObservedObject private var viewModel = ContentViewModel()
    
    // MARK: - View
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            if authManager.currentUser == nil {
                
                LoginView()
                
            } else {
                
                HStack(alignment: .center) {
                    
                    Text(authManager.currentUser?.name ?? ContentViewModel.Strings.userPlaceholderName)
                        .font(.system(Font.TextStyle.footnote, design: .rounded))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                    
                    Spacer()
                    
                    Button(action: {
                        self.viewModel.toggleSettings()
                    }) {
                        Image("settings")
                            .resizable()
                            .frame(width: 14, height: 14)
                    }
                }
                
                Spacer(minLength: 20)
                
                if viewModel.settingsShown {
                    
                    Divider()
                    
                    SettingsView()
                }
                
                Divider()
                
                TimeEntriesView()
            }
            
        }.padding()
    }
}
