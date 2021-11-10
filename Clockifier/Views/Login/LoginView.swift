//
//  LoginView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: LoginViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            VStack(alignment: .center) {
                Text(LoginViewModel.Strings.welcomTitle)
                    .font(.system(Font.TextStyle.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(LoginViewModel.Strings.welcomeSubtitle)
                    .font(.system(Font.TextStyle.headline, design: .rounded))
                    .fontWeight(.semibold)
            }
            
            HStack {
                SecureField(LoginViewModel.Strings.textfieldPlaceholder, text: $viewModel.clockifyApiKey)
                Button(LoginViewModel.Strings.loginButton, action: viewModel.didTapLogin)
                    .disabled(viewModel.clockifyApiKey.isEmpty)
            }
            .padding()
            
            if viewModel.loginError && !viewModel.clockifyApiKey.isEmpty {
                Text(LoginViewModel.Strings.loginError)
                    .font(.system(Font.TextStyle.footnote, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }
            
            Divider()
            
            Text(LoginViewModel.Strings.loginTips)
                .font(.system(Font.TextStyle.footnote, design: .rounded))
                .fontWeight(.regular)
                .frame(width: nil, height: 100, alignment: .center)
            
            Button(SettingsViewModel.Strings.quitAppButton, action: viewModel.quitApp)
        }
    }
}
