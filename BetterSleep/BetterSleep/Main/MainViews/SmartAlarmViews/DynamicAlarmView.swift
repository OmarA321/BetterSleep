//
//  DynamicAlarmView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-12.
//

import SwiftUI

struct DynamicAlarmView: View {
    @StateObject var viewModel = SmartAlarmViewModel()
    @State private var optimalAlarmDate: Date?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Select The Time You Wish To Wake Up:")
            DatePicker("Wake up time", selection: $viewModel.selectedTimeToWake, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            Button("Set Dynamic Alarm") {
                Task {
                    await viewModel.updateUserAlarm()
                }
                viewModel.showingPopup = true
            }
            .padding()
            .foregroundColor(Color.white)
            .background(
                Group {
                    if viewModel.preferences.antiBlueLightMode {
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
            .alert(isPresented: $viewModel.showingPopup) {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let selectedTime = formatter.string(from: viewModel.selectedTimeToWake)
                return Alert(title: Text("Dynamic Alarm - \(selectedTime)"),
                     message: Text("""
                                    We'll wake you up as close to \(selectedTime) as possible, while accounting for your sleep cycles.
                                  
                                    Have a goodnight!
                                  """),
                     dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                     })
            }
            Spacer()
        }
        .padding()
        .onAppear(){
            Task {
                await viewModel.fetchUser()
            }
        }
    }
}

