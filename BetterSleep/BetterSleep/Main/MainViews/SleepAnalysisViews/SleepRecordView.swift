//
//  SleepRecordView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct SleepRecordView: View {
    @Binding var antiBlueLightMode: Bool
    
    let date: Date
    let hoursSlept: Double
    let qualityRating: String
    
    var body: some View {
        
        
        VStack {
            HStack{
                Text(date, style: .date)
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text("Sleep Duration: \(String(format: "%.1f", hoursSlept)) hours")
                Spacer()
                Text("Sleep Rating: \(qualityRating)")
            }
            .padding(.vertical, 4)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(antiBlueLightMode ? #colorLiteral(red: 1, green: 0.5843137503, blue: 0, alpha: 1) : #colorLiteral(red: 0.1004742309, green: 0.2931964099, blue: 0.1928038299, alpha: 1)), Color(antiBlueLightMode ? #colorLiteral(red: 1, green: 0.4234874403, blue: 0.1089703062, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7725490332, blue: 0.5725490451, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(8)
    }
}

