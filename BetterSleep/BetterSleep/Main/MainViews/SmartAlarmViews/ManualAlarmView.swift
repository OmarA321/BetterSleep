//
//  ManualAlarmView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-12.
//

import SwiftUI

struct ManualAlarmView: View {
    @Binding var antiBlueLightMode: Bool
    
    @Binding var selectedTimeToWakeUp: Date
    @Binding var selectedTimeToSleep: Date
    
    @Binding var isCalculatingOptimalSleepTimes: Bool
    @Binding var isCalculatingOptimalWakeTimes: Bool
    
    @Binding var suggestedSleepTimes: [Date]
    @Binding var suggestedWakeTimes: [Date]
    
    @State private var isSelectingSleepTime = false
    @State private var isSelectingWakeTime = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isSelectingSleepTime = false
                }) {
                    Text("Wake Up Time")
                        .padding()
                        .background(
                            Group {
                                if isSelectingSleepTime {
                                    Color.clear
                                } else if antiBlueLightMode {
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
                                        Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
                                    ]), startPoint: .top, endPoint: .bottom)
                                } else {
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
                                        Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
                                    ]), startPoint: .top, endPoint: .bottom)
                                }
                            }
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    isSelectingSleepTime = true
                }) {
                    Text("Sleep Time")
                        .padding()
                        .background(
                            Group {
                                if !isSelectingSleepTime {
                                    Color.clear
                                } else if antiBlueLightMode {
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
                                        Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
                                    ]), startPoint: .top, endPoint: .bottom)
                                } else {
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
                                        Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
                                    ]), startPoint: .top, endPoint: .bottom)
                                }
                            }
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            .background(Color.gray.opacity(0.75))
            .cornerRadius(15)
            
            if isSelectingSleepTime {
                Text("Select The Time You Wish To Sleep:")
                    .padding(.top, 10)
                    .padding(.bottom, -10)
                DatePicker("Select Sleep Time", selection: $selectedTimeToSleep, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                Button("Calculate Optimal Times To Wake Up") {
                    isCalculatingOptimalWakeTimes = true
                    suggestedWakeTimes = calculateOptimalWakeTimes()
                }
                .padding()
                .foregroundColor(Color.white)
                .background(
                    Group {
                        if antiBlueLightMode {
                            LinearGradient(gradient: Gradient(colors: [
                                Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
                                Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
                            ]), startPoint: .top, endPoint: .bottom)
                        } else {
                            LinearGradient(gradient: Gradient(colors: [
                                Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
                                Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
                            ]), startPoint: .top, endPoint: .bottom)
                        }
                    }
                )
                .cornerRadius(8)
            } else {
               Text("Select The Time You Wish To Wake Up:")
                   .padding(.top, 10)
                   .padding(.bottom, -10)
               DatePicker("Select Wake Up Time", selection: $selectedTimeToWakeUp, displayedComponents: .hourAndMinute)
                   .labelsHidden()
                   .datePickerStyle(WheelDatePickerStyle())
                   .padding()
               Button("Calculate Optimal Times To Sleep") {
                   isCalculatingOptimalSleepTimes = true
                   suggestedSleepTimes = calculateOptimalSleepTimes()
               }
               .padding()
               .foregroundColor(Color.white)
               .background(
                   Group {
                       if antiBlueLightMode {
                           LinearGradient(gradient: Gradient(colors: [
                               Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
                               Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
                           ]), startPoint: .top, endPoint: .bottom)
                       } else {
                           LinearGradient(gradient: Gradient(colors: [
                               Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
                               Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
                           ]), startPoint: .top, endPoint: .bottom)
                       }
                   }
               )
               .cornerRadius(8)
           }
       }
       .padding()
   }
    private func calculateOptimalWakeTimes() -> [Date] {
        var suggestedTimes: [Date] = []
        let selectedTime = selectedTimeToSleep
        
        let calendar = Calendar.current
        let decrements: [TimeInterval] = [6 * 3600, 7.5 * 3600, 9 * 3600]
        
        for decrement in decrements {
            let suggestedTime = calendar.date(byAdding: .second, value: Int(decrement), to: selectedTime)!
            suggestedTimes.append(suggestedTime)
        }
        
        return suggestedTimes
    }
    
    private func calculateOptimalSleepTimes() -> [Date] {
        var suggestedTimes: [Date] = []
        let selectedTime = selectedTimeToWakeUp
        
        let calendar = Calendar.current
        let increments: [TimeInterval] = [-6 * 3600, -7.5 * 3600, -9 * 3600]
        
        for increment in increments {
            let suggestedTime = calendar.date(byAdding: .second, value: Int(increment), to: selectedTime)!
            suggestedTimes.append(suggestedTime)
        }
        
        return suggestedTimes
    }
}
