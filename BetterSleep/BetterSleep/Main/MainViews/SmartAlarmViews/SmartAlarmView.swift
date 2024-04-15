//
//  SmartAlarmView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import SwiftUI
import AVFoundation

struct SmartAlarmView: View {
    @StateObject var viewModel = SmartAlarmViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "alarm.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(viewModel.preferences.antiBlueLightMode ? Color.yellow : Color.blue)
                    .padding()
                
                Text("Smart Alarm")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Spacer()
                
                // if no alarm is set
                if !viewModel.alarmSet {
                    VStack {
                        Text("No Alarm Set")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding()
                        
                        NavigationLink(destination: DynamicAlarmView()) {
                            Text("Set Dynamic Alarm")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .foregroundColor(.white)
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
                        .cornerRadius(20)
                        .padding(.horizontal, 30)
                        NavigationLink(destination: ManualAlarmView()) {
                            Text("Set Manual Alarm")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
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
                        .cornerRadius(20)
                        .padding(.horizontal, 30)
                        
                        Spacer()
                    }
                    
                }
                
                // if alarm is set
                else {
                    VStack {
                        Text("Alarm Set For \(viewModel.selectedTimeToWake, formatter: DateFormatter.timeOnly)")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding()
                        
                        Button(action: {
                            withAnimation {
                                viewModel.selectedTimeToWake = Date()
                                viewModel.selectedTimeToSleep = Date()
                                viewModel.alarmSet = false
                                Task {
                                    await viewModel.deleteUserAlarm()
                                }
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 150, height: 150)
                                
                                Text("Delete Alarm")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        .foregroundColor(.white)
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
                        
                        Spacer()
                    }
                    
                }
            }
        }
        .onAppear(){
            Task {
                await viewModel.fetchUser()
            }
        }
        .onReceive(Timer.publish(every: 2, on: .main, in: .default).autoconnect()) { _ in
            let calendar = Calendar.current
            
            let currentTime = Date()
            let selectedTime = viewModel.selectedTimeToWake
            
            if viewModel.alarmSet {
                if calendar.isDate(currentTime, equalTo: selectedTime, toGranularity: .minute){
                    viewModel.playAlarmSound()
                    viewModel.alarmSet = false
                    Task {
                        await viewModel.deleteUserAlarm()
                    }
                }
            }
        }
        .onReceive(Timer.publish(every: 600, on: .main, in: .default).autoconnect()) { _ in
            let calendar = Calendar.current
            
            let currentTime = Date()
            let selectedTime = viewModel.selectedTimeToWake
            
            let targetTime = calendar.date(byAdding: .minute, value: -90, to: selectedTime) ?? selectedTime
            
            if currentTime >= targetTime {
                if viewModel.dynamicAlarm {
                    viewModel.requestSleepAuthorization()
                    viewModel.dynamicAlarm = false
                }
            }
        }
    }
}


extension DateFormatter {
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
