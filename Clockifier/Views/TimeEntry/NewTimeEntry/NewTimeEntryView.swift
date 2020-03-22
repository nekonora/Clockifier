//
//  NewTimeEntryView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 22/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct NewTimeEntryView: View {
    
    var projects = [Project]()
    
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
                
                VStack {
                    HStack {
                        DatePicker(NewTimeEntryViewModel.Strings.formFromHour,
                               selection: $viewModel.selectedFromTime,
                               displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        
                        Image("arrow_down")
                            .resizable()
                            .frame(width: 12, height: 14)
                        
                        DatePicker(NewTimeEntryViewModel.Strings.formToHour,
                               selection: $viewModel.selectedToTime,
                               displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    Text(viewModel.durationDesc)
                        .font(.system(Font.TextStyle.caption, design: .rounded))
                        .fontWeight(.regular)
                        .padding()
                        .frame(width: .none, height: 18, alignment: .center)
                        .background(Color(.controlAccentColor))
                        .cornerRadius(9)
                    
                    Picker(selection: $viewModel.selectedProject, label: Text(NewTimeEntryViewModel.Strings.formProject)) {
                        ForEach(0 ..< projects.count) {
                            Text(self.projects[$0].name)
                        }
                    }
                    
                    TextField("Description", text: $viewModel.description)
                    
                    Button(NewTimeEntryViewModel.Strings.addEntryButton) {
                        print(
                            self.viewModel.startDate,
                            self.viewModel.endDate
                        )
                    }
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
