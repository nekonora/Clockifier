//
//  SettingsView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Observables
    
    @ObservedObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        
        HStack {
            
            Text(SettingsViewModel.Strings.settingsTitle)
                .font(.system(Font.TextStyle.headline, design: .rounded))
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(SettingsViewModel.Strings.logOutButton) { self.viewModel.logOut() }
            
            Button(SettingsViewModel.Strings.quitAppButton) { self.viewModel.quitApp() }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
