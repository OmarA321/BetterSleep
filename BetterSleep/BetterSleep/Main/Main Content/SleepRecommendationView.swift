//
//  SleepRecommendationView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import SwiftUI

struct SleepRecommendationView: View {
    @StateObject var viewModel = SleepRecommendationViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "moon.haze.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(
                        viewModel.preferences.antiBlueLightMode ? Color(red: 1.0, green: 0.4, blue: 0.4) : Color.purple
                    )
                    .padding()
                
                Text("Sleep Recommendations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .padding(.top, -10)
                
                Text("Based on your sleep patterns, we recommend the following:")
                    .font(.body)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("Time to Sleep")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("10:00 PM")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(viewModel.preferences.antiBlueLightMode ? Color(red: 1.0, green: 0.4, blue: 0.4) : Color.purple)
                    )
                    Spacer()
                    VStack {
                        Text("Time to Wake Up")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("6:00 AM")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(viewModel.preferences.antiBlueLightMode ? Color(red: 1.0, green: 0.4, blue: 0.4) : Color.purple)
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Text("Additional Recommendations:")
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.recommendations, id: \.self) { recommendation in
                        RecommendationRow(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode, title: recommendation.title, description: recommendation.description)
                    }
//                    RecommendationRow(antiBlueLightMode: $antiBlueLightMode, title: "Avoid Caffeine", description: "Try to avoid caffeine intake at least 6 hours before your recommended sleep time.")
//                    RecommendationRow(antiBlueLightMode: $antiBlueLightMode, title: "Create a Bedtime Routine", description: "Establish a relaxing bedtime routine to signal to your body that it's time to wind down.")
//                    RecommendationRow(antiBlueLightMode: $antiBlueLightMode, title: "Limit Screen Time", description: "Reduce exposure to screens and bright lights at least an hour before bedtime to promote better sleep.")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Spacer()
                
                Divider().padding(.horizontal, 20)
                
                Text("These recommendations are based on your individual sleep patterns and aim to optimize your sleep quality and overall well-being.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
            }
        }
    }
}

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
