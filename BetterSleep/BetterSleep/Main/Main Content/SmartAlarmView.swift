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
    
    @Binding var selectedTimeToWake: Date
    @Binding var selectedTimeToSleep: Date
    @Binding var alarmSet: Bool
    
    @State private var isCalculatingOptimalSleepTimes = false
    @State private var suggestedSleepTimes: [Date] = []
    
    @State private var isCalculatingOptimalWakeTimes = false
    @State private var suggestedWakeTimes: [Date] = []
    
    @State private var showingPopup = false
    @State private var settingAlarm = false
    
    @State private var showLeftWakeTimes = false
    @State private var showRightWakeTimes = false
    @State private var showLeftSleepTimes = false
    @State private var showRightSleepTimes = false
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "alarm.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(antiBlueLightMode ? Color.yellow : Color.blue)
                    .padding()
                
                Text("Smart Alarm")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Spacer()
                
                if !alarmSet && settingAlarm == false {
                    VStack {
                        Text("No Alarm Set")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding()
                        
                        Button(action: {
                            withAnimation{
                                settingAlarm = true
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 150, height: 150)
                                
                                Text("Set Alarm")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        .foregroundColor(.white)
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
                        
                        Spacer()
                    }
                    
                } else if alarmSet && settingAlarm == false{
                    VStack {
                        Text("Alarm Set For \(selectedTimeToWake, formatter: DateFormatter.timeOnly)")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding()
                        
                        Button(action: {
                            withAnimation {
                                selectedTimeToWake = Date()
                                selectedTimeToSleep = Date()
                                alarmSet = false
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
                        
                        Spacer()
                    }
                    
                } else if settingAlarm == true{
                    VStack {
                        Text("Select alarm type:")
                        
                        HStack {
                            Button(action: {
                                isDynamicAlarmSelected = true
                                isManualAlarmSelected = false
                            }) {
                                Text("Dynamic Alarm")
                                    .padding()
                                    .background(
                                        Group {
                                            if isDynamicAlarmSelected {
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
                                            } else {
                                                Color.clear
                                            }
                                        }
                                    )
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isDynamicAlarmSelected = false
                                isManualAlarmSelected = true
                            }) {
                                Text("Manual Alarm")
                                    .padding()
                                    .background(
                                        Group {
                                            if isManualAlarmSelected {
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
                                            } else {
                                                Color.clear
                                            }
                                        }
                                    )
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    
                    if isDynamicAlarmSelected {
                        DynamicAlarmView(antiBlueLightMode: $antiBlueLightMode, selectedWakeUpTime: $selectedTimeToWake)
                    } else if isManualAlarmSelected {
                        ManualAlarmView(antiBlueLightMode: $antiBlueLightMode, selectedTimeToWakeUp: $selectedTimeToWake, selectedTimeToSleep: $selectedTimeToSleep, isCalculatingOptimalSleepTimes: $isCalculatingOptimalSleepTimes, isCalculatingOptimalWakeTimes: $isCalculatingOptimalWakeTimes, suggestedSleepTimes: $suggestedSleepTimes, suggestedWakeTimes: $suggestedWakeTimes)
                    }
                    
                    Spacer()
                }
            }
            
            if isCalculatingOptimalWakeTimes {
                Color.black.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack {
                        Text("Please Select Wake Up Time:")
                            .font(.headline)
                            .bold()
                        
                        Text("You are Sleeping at \(selectedTimeToSleep, formatter: DateFormatter.timeOnly)")
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 150, height: 150)
                            .overlay(
                                VStack {
                                    Text("\(suggestedWakeTimes[0], formatter: DateFormatter.timeOnly)")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                    Text("6 hours of sleep")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )
                            .onTapGesture {
                                selectedTimeToWake = suggestedWakeTimes[0]
                                showingPopup = true
                            }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 150, height: 150)
                            .overlay(
                                VStack {
                                    Text("\(suggestedWakeTimes[1], formatter: DateFormatter.timeOnly)")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                    Text("7.5 hours of sleep")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )
                            .onTapGesture {
                                selectedTimeToWake = suggestedWakeTimes[1]
                                showingPopup = true
                            }
                    }
                    
                    if suggestedWakeTimes.count >= 3 {
                        HStack(spacing: 20) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(showLeftWakeTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
                                .font(Font.system(size: 50))
                                .bold()
                                .onTapGesture {
                                    if showLeftWakeTimes == false && showRightWakeTimes == false{
                                        showLeftWakeTimes = true
                                    }
                                    else if showLeftWakeTimes == false && showRightWakeTimes == true{
                                        showRightWakeTimes = false
                                    }
                                }
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                                )
                                .frame(width: 150, height: 150)
                                .overlay(
                                    VStack {
                                        Text("\(suggestedWakeTimes[2], formatter: DateFormatter.timeOnly)")
                                            .foregroundColor(.white)
                                            .font(.title)
                                            .bold()
                                        Text("9 hours of sleep")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }
                                )
                                .onTapGesture {
                                    selectedTimeToWake = suggestedWakeTimes[2]
                                    showingPopup = true
                                }
                            Image(systemName: "arrow.right")
                                .foregroundColor(showRightWakeTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
                                .font(Font.system(size: 50))
                                .bold()
                                .onTapGesture {
                                    if showLeftWakeTimes == false && showRightWakeTimes == false{
                                        showRightWakeTimes = true
                                    }
                                    else if showLeftWakeTimes == true && showRightWakeTimes == false{
                                        showLeftWakeTimes = false
                                    }
                                }
                        }
                    }
                }
                .alert(isPresented: $showingPopup) {
                    let formatter = DateFormatter()
                    formatter.timeStyle = .short
                    return Alert(title: Text("Manual Alarm Set"),
                                 message: Text("""
                                              Sleep Time - \(formatter.string(from: selectedTimeToSleep))
                                              Wake Time - \(formatter.string(from: selectedTimeToWake))
                                              
                                              Have a goodnight!
                                              """),
                                 dismissButton: .default(Text("OK")) {
                                    isCalculatingOptimalSleepTimes = false
                                    alarmSet = true
                                    presentationMode.wrappedValue.dismiss()
                                 })
                }
            } else if isCalculatingOptimalSleepTimes {
                Color.black.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack {
                        Text("Please Select Sleep Time:")
                            .font(.headline)
                            .bold()
                        
                        Text("You are Waking at \(selectedTimeToWake, formatter: DateFormatter.timeOnly)")
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 150, height: 150)
                            .overlay(
                                VStack {
                                    Text("\(showLeftSleepTimes ? suggestedSleepTimes[0].addingTimeInterval(4.5 * 3600) : suggestedSleepTimes[0], formatter: DateFormatter.timeOnly)")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                    Text("\(showLeftSleepTimes ? "1.5" : "6") hours of sleep")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )
                            .onTapGesture {
                                if showLeftSleepTimes == true{
                                    selectedTimeToSleep = suggestedSleepTimes[0].addingTimeInterval(4.5 * 3600)
                                }
                                else if showRightSleepTimes == true{
                                    selectedTimeToSleep = suggestedSleepTimes[0].addingTimeInterval(-4.5 * 3600)
                                }
                                else {
                                    selectedTimeToSleep = suggestedSleepTimes[0]
                                }
                                showingPopup = true
                            }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 150, height: 150)
                            .overlay(
                                VStack {
                                    Text("\(showLeftSleepTimes ? suggestedSleepTimes[1].addingTimeInterval(4.5 * 3600) : suggestedSleepTimes[1], formatter: DateFormatter.timeOnly)")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                    Text("\(showLeftSleepTimes ? "3" : "7.5") hours of sleep")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                            )
                            .onTapGesture {
                                if showLeftSleepTimes == true{
                                    selectedTimeToSleep = suggestedSleepTimes[1].addingTimeInterval(4.5 * 3600)
                                }
                                else if showRightSleepTimes == true{
                                    selectedTimeToSleep = suggestedSleepTimes[1].addingTimeInterval(-4.5 * 3600)
                                }
                                else {
                                    selectedTimeToSleep = suggestedSleepTimes[1]
                                }
                                showingPopup = true
                            }
                    }
                    
                    if suggestedSleepTimes.count >= 3 {
                        HStack(spacing: 20) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(showLeftSleepTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
                                .font(Font.system(size: 50))
                                .bold()
                                .onTapGesture {
                                    if showLeftSleepTimes == false && showRightSleepTimes == false{
                                        showLeftSleepTimes = true
                                    }
                                    else if showLeftSleepTimes == false && showRightSleepTimes == true{
                                        showRightSleepTimes = false
                                    }
                                }
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                                )
                                .frame(width: 150, height: 150)
                                .overlay(
                                    VStack {
                                        Text("\(showLeftSleepTimes ? suggestedSleepTimes[2].addingTimeInterval(4.5 * 3600) : suggestedSleepTimes[2], formatter: DateFormatter.timeOnly)")
                                            .foregroundColor(.white)
                                            .font(.title)
                                            .bold()
                                        Text("\(showLeftSleepTimes ? "4.5" : "9") hours of sleep")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }
                                )
                                .onTapGesture {
                                    if showLeftSleepTimes == true{
                                        selectedTimeToSleep = suggestedSleepTimes[2].addingTimeInterval(4.5 * 3600)
                                    }
                                    else if showRightSleepTimes == true{
                                        selectedTimeToSleep = suggestedSleepTimes[2].addingTimeInterval(-4.5 * 3600)
                                    }
                                    else {
                                        selectedTimeToSleep = suggestedSleepTimes[2]
                                    }
                                    showingPopup = true
                                }
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(showRightSleepTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
                                .font(Font.system(size: 50))
                                .bold()
                                .onTapGesture {
                                    if showLeftSleepTimes == false && showRightSleepTimes == false{
                                        showRightSleepTimes = true
                                    }
                                    else if showLeftSleepTimes == true && showRightSleepTimes == false{
                                        showLeftSleepTimes = false
                                    }
                                }
                        }
                    }
                }
                .alert(isPresented: $showingPopup) {
                    let formatter = DateFormatter()
                    formatter.timeStyle = .short
                    return Alert(title: Text("Manual Alarm Set"),
                         message: Text("""
                                      Sleep Time - \(formatter.string(from: selectedTimeToSleep))
                                      Wake Time - \(formatter.string(from: selectedTimeToWake))
                                      
                                      Have a goodnight!
                                      """),
                         dismissButton: .default(Text("OK")) {
                            isCalculatingOptimalSleepTimes = false
                            alarmSet = true
                            presentationMode.wrappedValue.dismiss()
                         })
                }
            }
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
            Text("Select The Time You Wish To Wake Up:")
            DatePicker("Wake up time", selection: $selectedWakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
            Button("Set Dynamic Alarm") {
                showingPopup = true
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
            .alert(isPresented: $showingPopup) {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let selectedTime = formatter.string(from: selectedWakeUpTime)
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
    }
}

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

extension DateFormatter {
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
