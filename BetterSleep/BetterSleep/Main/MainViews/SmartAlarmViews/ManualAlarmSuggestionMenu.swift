//
//  ManualAlarmSuggestionMenu.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-14.
//

import SwiftUI

struct ManualAlarmSuggestionMenu: View {
    
    @ObservedObject var viewModel: ManualAlarmViewModel
    @Binding var isShowingSuggestedTimes: Bool
    var isSettingSleepTime: Bool
    
    var body: some View {
        
        Spacer()
        Color.black.opacity(0.8).ignoresSafeArea()
        VStack(spacing: 20) {
            VStack {
                if isSettingSleepTime {
                    Text("Please Select Sleep Time:")
                        .font(.headline)
                        .bold()
                    
                    Text("You are waking up at \(viewModel.selectedTimeToWake, formatter: DateFormatter.timeOnly)")
                        .font(.subheadline)
                    
                } else {
                    Text("Please Select Wake Up Time:")
                        .font(.headline)
                        .bold()
                    
                    Text("You are sleeping at \(viewModel.selectedTimeToSleep, formatter: DateFormatter.timeOnly)")
                        .font(.subheadline)
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(10)
            
            Spacer()
            
            ScrollView(.horizontal){
                HStack(spacing: 20) {
                    ForEach(viewModel.suggestedTimes.sorted(by: <), id: \.key) { hours, suggestedTime in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 150, height: 150)
                            .overlay(
                                VStack {
                                    Text("\(suggestedTime, formatter: DateFormatter.timeOnly)")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                    Text("\(hours, specifier: "%.1f") hours of sleep")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )
                            .onTapGesture {
                                
                                if isSettingSleepTime {
                                    viewModel.selectedTimeToSleep = suggestedTime
                                } else {
                                    viewModel.selectedTimeToWake = suggestedTime
                                }
                                isShowingSuggestedTimes = false
                                print(#function, "user: \(viewModel.user)")
                                Task {
                                    await viewModel.updateUserAlarm()
                                    
                                }
                                
                            }
                    }
                }
            }
            Spacer()
        }
        .frame(height: 400)
        .onAppear {
            Task {
                await viewModel.fetchUser()
            }
        }
        .onDisappear {
            viewModel.showingPopup = true
        }
    }
}

