//
//  RecommendationRow.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI


struct RecommendationRow: View {
    @Binding var antiBlueLightMode: Bool
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(
                    antiBlueLightMode ? Color(red: 1.0, green: 0.4, blue: 0.4) : Color.purple
                )
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
        }
    }
}
