//
//  AddSingleDaySleepDataView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct AddSingleDaySleepDataView: View {
    @StateObject var viewModel = SleepAnalysisViewModel()
    
    
    var body: some View {
        VStack {
            Text("Record Sleep")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
            
            DatePicker("Sleep Time:", selection: $viewModel.sleepTime, displayedComponents: [.date, .hourAndMinute])
                .padding()
            
            DatePicker("Wake Up Time:", selection: $viewModel.wakeUpTime, displayedComponents: [.date, .hourAndMinute])
                .padding()
            
            HStack {
                Text("Sleep Quality:")
                Spacer()
                Picker("", selection: $viewModel.selectedSleepQuality) {
                    ForEach(viewModel.sleepQualityOptions, id: \.self) {
                        Text($0)
                    }
                }
            }
            .padding()
            
            Button(action: {
                Task {
                    await viewModel.addUserSleepRecord()
                }
            }) {
                Text("Save")
                    .padding(EdgeInsets(top: 20, leading: 100, bottom: 20, trailing: 100))
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.4234874403, blue: 0.1089703062, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .onAppear(){
            Task {
                await viewModel.fetchUser()
            }
        }
    }
}
