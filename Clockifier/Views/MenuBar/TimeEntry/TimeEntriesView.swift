//
//  TimeEntryView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct TimeEntriesView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: TimeEntriesViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NewTimeEntryView(viewModel: NewTimeEntryViewModel())
            
            Spacer(minLength: 10)
            
            Divider()
            
            Text(TimeEntriesViewModel.Strings.pastEntriesTitle)
                .font(.system(Font.TextStyle.headline, design: .rounded))
                .fontWeight(.semibold)
            
            HStack {
                Text(TimeEntriesViewModel.Strings.legendProject)
                    .font(.system(Font.TextStyle.caption, design: .rounded))
                    .frame(width: 180, height: 10, alignment: .leading)
                
                Text(TimeEntriesViewModel.Strings.legendDate)
                    .font(.system(Font.TextStyle.caption, design: .rounded))
                    .frame(width: 120, height: 10, alignment: .leading)
                
                Text(TimeEntriesViewModel.Strings.legendDuration)
                    .font(.system(Font.TextStyle.caption, design: .rounded))
                    .frame(width: 100, height: 10, alignment: .leading)
            }
            
            TimeEntriesList(timeEntries: viewModel.timeEntries)
        }
    }
}
