//
//  NewTimeEntryView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct NewTimeEntryView: View {
    
    @ObservedObject private var viewModel = NewTimeEntryViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(NewTimeEntryViewModel.Strings.quickEntryTitle)
                .font(.system(Font.TextStyle.headline, design: .rounded))
                .fontWeight(.semibold)
            
            HStack {
                DatePicker(NewTimeEntryViewModel.Strings.formDay,
                           selection: $viewModel.selectedDate,
                           displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())

                VStack(alignment: .trailing) {
                    HStack {
                        DatePicker(NewTimeEntryViewModel.Strings.formFromHour,
                                   selection: $viewModel.selectedFromTime,
                                   displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        
                        Image("arrow_right")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        DatePicker(NewTimeEntryViewModel.Strings.formToHour,
                                   selection: $viewModel.selectedToTime,
                                   displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    Text(viewModel.durationDesc)
                        .font(.system(Font.TextStyle.caption, design: .rounded))
                        .fontWeight(.regular)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20)
                        .background(Color(.controlAccentColor))
                        .cornerRadius(9)
                    
                    Picker(selection: $viewModel.selectedProjectId, label: Text(NewTimeEntryViewModel.Strings.formProject)) {
                        ForEach(ProjectsManager.shared.projects, id: \.id) { Text($0.name).tag($0.id) }
                    }
                    
                    TextField(NewTimeEntryViewModel.Strings.description, text: $viewModel.description)
                    
                    Button(NewTimeEntryViewModel.Strings.addEntryButton) { self.viewModel.addTimeEntry() }
                }
            }
        }
    }
}

extension NewTimeEntryView {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

struct NewTimeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewTimeEntryView()
    }
}
