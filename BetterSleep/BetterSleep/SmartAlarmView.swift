//
//  SmartAlarmView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import SwiftUI

struct SmartAlarmView: View {
    @Binding var antiBlueLightMode: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isDynamicAlarmSelected = true
    @State private var isManualAlarmSelected = false
    
    @State private var isSetTimeToWakeUp = false
    @State private var isSetTimeToSleep = false
    
    @State private var selectedTimeToWakeUp = Date()
    @State private var selectedTimeToSleep = Date()
    
    var body: some View {
        VStack {
            Image(systemName: "alarm.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 100)
                .foregroundColor(
                    antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue
                )
                .padding()
            
            Text("Smart Alarm")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Spacer()
            
            VStack {
                Text("Select alarm type:")
                
                HStack {
                    Button(action: {
                        isDynamicAlarmSelected = true
                        isManualAlarmSelected = false
                    }) {
                        Text("Dynamic Alarm")
                            .padding()
                            .background(isDynamicAlarmSelected ? (antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue) : Color.clear)
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        isDynamicAlarmSelected = false
                        isManualAlarmSelected = true
                    }) {
                        Text("Manual Alarm")
                            .padding()
                            .background(isManualAlarmSelected ? (antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue) : Color.clear)
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    }
                }
            }
            
            if isDynamicAlarmSelected {
                DynamicAlarmView(antiBlueLightMode: $antiBlueLightMode, selectedWakeUpTime: $selectedTimeToWakeUp)
            } else if isManualAlarmSelected {
                ManualAlarmView(antiBlueLightMode: $antiBlueLightMode, selectedTimeToWakeUp: $selectedTimeToWakeUp)
            }
            
            Spacer()
        }
    }
}

struct DynamicAlarmView: View {
    @Binding var antiBlueLightMode: Bool
    @Binding var selectedWakeUpTime: Date
    @State private var showingPopup = false
    @State private var optimalAlarmDate: Date?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Please Select Wake Up Time:")
            DatePicker("Wake up time", selection: $selectedWakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            Button("Set Dynamic Alarm") {
                showingPopup = true
            }
            .padding()
            .foregroundColor(Color.white)
            .background(antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue)
            .cornerRadius(8)
            .alert(isPresented: $showingPopup) {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let selectedTime = formatter.string(from: selectedWakeUpTime)
                return Alert(title: Text("Dynamic Alarm Set for \(selectedTime)"),
                     message: Text("""
                                    We'll wake you up as close to your time as possible, while accounting for your sleep cycles.
                                    Have a goodnight!
                                  """),
                     dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                     })
            }
        }
        .padding()
    }
}

struct ManualAlarmView: View {
    @Binding var antiBlueLightMode: Bool
    @Binding var selectedTimeToWakeUp: Date
    @State private var selectedTimeToSleep: Date = Date()
    @State private var isSelectingSleepTime = false
    
    @State private var recommendedWakeUpTimes: [Date] = []
    @State private var wakeUpTimeInput: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isSelectingSleepTime = false
                }) {
                    Text("Wake Up Time")
                        .padding()
                        .background(isSelectingSleepTime ? Color.clear : (antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    isSelectingSleepTime = true
                }) {
                    Text("Sleep Time")
                        .padding()
                        .background(isSelectingSleepTime ? (antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue) : Color.clear)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            .background(Color.gray.opacity(0.75))
            .cornerRadius(15)
            
            if isSelectingSleepTime {
                Text("Please Select Sleep Time:")
                    .padding(.top, 10)
                    .padding(.bottom, -10)
                DatePicker("Select Sleep Time", selection: $selectedTimeToSleep, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                Button("Calculate Optimal Wake Up Times") {
                    //Calculate
                }
                .padding()
                .foregroundColor(Color.white)
                .background(antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue)
                .cornerRadius(8)
            } else {
                Text("Please Select Wake Up Time:")
                    .padding(.top, 10)
                    .padding(.bottom, -10)
                DatePicker("Select Wake Up Time", selection: $wakeUpTimeInput, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                Button("Calculate Optimal Sleep Times") {
                    //Calculate
                }
                .padding()
                .foregroundColor(Color.white)
                .background(antiBlueLightMode ? Color(hue: 0.15, saturation: 1.0, brightness: 0.7) : Color.blue)
                .cornerRadius(8)
            }
        }
        .padding()
    }
        
    private func formatTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: time)
    }
}

extension DateFormatter {
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
