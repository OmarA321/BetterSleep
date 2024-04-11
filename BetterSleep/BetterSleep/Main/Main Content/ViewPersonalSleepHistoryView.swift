//
//  ViewPersonalSleepHistoryView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct ViewPersonalSleepHistoryView: View {
    @StateObject var viewModel = SleepAnalysisViewModel()
    var body: some View {
        VStack {
            Text("Sleep History")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
                .padding()
            ForEach(viewModel.sleepHistory, id: \.self) { record in
                SleepRecordView(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode, date: "date placeholder", hoursSlept: record.hoursSlept, qualityRating: record.qualityRating)
                
            }
            
//            SleepRecordView(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode, date: "February 28, 2024", hoursSlept: 7, qualityRating: "Okay")
//            SleepRecordView(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode, date: "February 27, 2024", hoursSlept: 6.5, qualityRating: "Poor")
//            SleepRecordView(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode, date: "February 26, 2024", hoursSlept: 8, qualityRating: "Great")
            
            Spacer()
        }
    }
}
