//
//  SleepSummaryView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct SleepSummaryView: View {
    @StateObject var viewModel = SleepAnalysisViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Total Sleeps Recorded:")
                    .padding(.vertical, 20)
                    .fontWeight(.bold)
                Spacer()
                Text("\(viewModel.totalSleepRecords)")
                    .padding(.vertical, 20)
            }
            HStack {
                Text("Average Sleep Duration:")
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                Spacer()
                Text("\(String(format: "%.1f", viewModel.averageSleepDuration)) hours")
                    .padding(.vertical, 20)
            }
            HStack {
                Text("Average Sleep Rating:")
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                Spacer()
                Text(viewModel.averageSleepQuality)
                    .padding(.vertical, 20)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(viewModel.preferences.antiBlueLightMode ? #colorLiteral(red: 1, green: 0.4234874403, blue: 0.1089703062, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(8)
        .onAppear {
            Task {
                await viewModel.fetchUser()
            }
        }
    }
}
