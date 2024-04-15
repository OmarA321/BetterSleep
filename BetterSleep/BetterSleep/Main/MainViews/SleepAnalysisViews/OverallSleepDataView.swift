//
//  OverallSleepDataView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct OverallSleepDataView: View {
    @Binding var antiBlueLightMode: Bool
    
    var body: some View {
        VStack {
            Text("Overall Sleep Stats")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1)))
            
            SleepSummaryView()
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .navigationBarBackButtonHidden()
    }
}
