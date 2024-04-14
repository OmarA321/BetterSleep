//
//  ManualAlarmView.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-12.
//

import SwiftUI

struct ManualAlarmView: View {
    @ObservedObject var viewModel = ManualAlarmViewModel()
    
    @State private var isSelectingSleepTime = false
    @State private var isSelectingWakeTime = false
    
    @State var isShowingSuggestedTimes = false
    
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image(systemName: "alarm.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 100)
                .foregroundColor(viewModel.preferences.antiBlueLightMode ? Color.yellow : Color.blue)
                .padding()
            
            Text("Manual Alarm")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Spacer()
            
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
                                } else if viewModel.preferences.antiBlueLightMode {
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
                                } else if viewModel.preferences.antiBlueLightMode {
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
                DatePicker("Select Sleep Time", selection: $viewModel.selectedTimeToSleep, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                Button("Calculate Optimal Times To Wake Up") {
                    viewModel.calculateOptimalWakeTimes()
                    isShowingSuggestedTimes = true
                }
                .sheet(isPresented: $isShowingSuggestedTimes) {
                    ManualAlarmSuggestionMenu(viewModel: viewModel, isShowingSuggestedTimes: $isShowingSuggestedTimes, isSettingSleepTime: false)
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
            } else {
               Text("Select The Time You Wish To Wake Up:")
                   .padding(.top, 10)
                   .padding(.bottom, -10)
                DatePicker("Select Wake Up Time", selection: $viewModel.selectedTimeToWake, displayedComponents: .hourAndMinute)
                   .labelsHidden()
                   .datePickerStyle(WheelDatePickerStyle())
                   .padding()
               Button("Calculate Optimal Times To Sleep") {
                   viewModel.calculateOptimalSleepTimes()
                   isShowingSuggestedTimes = true
               }
               .sheet(isPresented: $isShowingSuggestedTimes) {
                   ManualAlarmSuggestionMenu(viewModel: viewModel, isShowingSuggestedTimes: $isShowingSuggestedTimes, isSettingSleepTime: true)
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
           }
       }
       .padding()
       .onAppear(){
           Task {
               await viewModel.fetchUser()
           }
       }
       .alert(isPresented: $viewModel.showingPopup) {
           let formatter = DateFormatter()
           formatter.timeStyle = .short
           return Alert(title: Text("Manual Alarm Set"),
                message: Text("""
                             Sleep Time - \(formatter.string(from: viewModel.selectedTimeToSleep))
                             Wake Time - \(formatter.string(from: viewModel.selectedTimeToWake))

                             Have a good night!
                             """),
                dismissButton: .default(Text("OK")) {
                   presentationMode.wrappedValue.dismiss()
                })
       }
   }
}
