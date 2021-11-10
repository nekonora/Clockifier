//
//  SettingsView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: SettingsViewModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(SettingsViewModel.Strings.settingsTitle)
                .font(.system(Font.TextStyle.headline, design: .rounded))
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(SettingsViewModel.Strings.logOutButton, action: viewModel.logOut)
            Button(SettingsViewModel.Strings.quitAppButton, action: viewModel.quitApp)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(authManager: .shared,
                                                  windowManager: .shared))
    }
}
