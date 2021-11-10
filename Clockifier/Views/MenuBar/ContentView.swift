//
//  ContentView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ContentViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.user == nil {
                LoginView(viewModel: LoginViewModel())
            } else {
                HStack(alignment: .center) {
                    Text(viewModel.user?.name ?? ContentViewModel.Strings.userPlaceholderName)
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
                    SettingsView(viewModel: SettingsViewModel())
                }
                
                Divider()
                TimeEntriesView(viewModel: TimeEntriesViewModel())
            }
        }
        .padding()
    }
}
