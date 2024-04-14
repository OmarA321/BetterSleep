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
                
                
                // default, viewing current alarm settings
                
                if !viewModel.settingAlarm {
                    
                    // if no alarm is set
                    if !viewModel.alarmSet {
                        VStack {
                            Text("No Alarm Set")
                                .foregroundColor(Color.white)
                                .font(.title3)
                                .padding()
                            
                            
                            //TODO: make these buttons look nice
                            NavigationLink(destination: DynamicAlarmView()) {
                                Text("set dynamic alarm")
                            }
                            NavigationLink(destination: ManualAlarmView()) {
                                Text("set manual alarm")
                            }
                            
//                            Button(action: {
//                                withAnimation{
//                                    viewModel.settingAlarm = true
//                                }
//                            }) {
//                                ZStack {
//                                    Rectangle()
//                                        .fill(Color.clear)
//                                        .frame(width: 150, height: 150)
//                                    
//                                    Text("Set Alarm")
//                                        .foregroundColor(.white)
//                                        .bold()
//                                }
//                            }
//                            .foregroundColor(.white)
//                            .background(
//                                Group {
//                                    if viewModel.preferences.antiBlueLightMode {
//                                        LinearGradient(gradient: Gradient(colors: [
//                                            Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
//                                            Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
//                                        ]), startPoint: .top, endPoint: .bottom)
//                                    } else {
//                                        LinearGradient(gradient: Gradient(colors: [
//                                            Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
//                                            Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
//                                        ]), startPoint: .top, endPoint: .bottom)
//                                    }
//                                }
//                            )
//                            .cornerRadius(8)
                            
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
                
                // setting alarm
                
//                else {
//                    VStack {
//                        Text("Select alarm type:")
//                        
//                        HStack {
//                            Button(action: {
//                                viewModel.isDynamicAlarmSelected = true
//                                viewModel.isManualAlarmSelected = false
//                            }) {
//                                Text("Dynamic Alarm")
//                                    .padding()
//                                    .background(
//                                        Group {
//                                            if viewModel.isDynamicAlarmSelected {
//                                                if viewModel.preferences.antiBlueLightMode {
//                                                    LinearGradient(gradient: Gradient(colors: [
//                                                        Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
//                                                        Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
//                                                    ]), startPoint: .top, endPoint: .bottom)
//                                                } else {
//                                                    LinearGradient(gradient: Gradient(colors: [
//                                                        Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
//                                                        Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
//                                                    ]), startPoint: .top, endPoint: .bottom)
//                                                }
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .foregroundColor(Color.white)
//                                    .cornerRadius(8)
//                            }
//                            
//                            Button(action: {
//                                viewModel.isDynamicAlarmSelected = false
//                                viewModel.isManualAlarmSelected = true
//                            }) {
//                                Text("Manual Alarm")
//                                    .padding()
//                                    .background(
//                                        Group {
//                                            if viewModel.isManualAlarmSelected {
//                                                if viewModel.preferences.antiBlueLightMode {
//                                                    LinearGradient(gradient: Gradient(colors: [
//                                                        Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)),
//                                                        Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))
//                                                    ]), startPoint: .top, endPoint: .bottom)
//                                                } else {
//                                                    LinearGradient(gradient: Gradient(colors: [
//                                                        Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)),
//                                                        Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))
//                                                    ]), startPoint: .top, endPoint: .bottom)
//                                                }
//                                            } else {
//                                                Color.clear
//                                            }
//                                        }
//                                    )
//                                    .foregroundColor(Color.white)
//                                    .cornerRadius(8)
//                            }
//                        }
//                    }
//                    
//                    if viewModel.isDynamicAlarmSelected {
//                        DynamicAlarmView()
//                    } else if viewModel.isManualAlarmSelected {
//                        ManualAlarmView()
//                    }
//                    
//                    Spacer()
//                }
            }
                    
                
                    
            
// Inputted Sleep Time, Calculating Optimal Wake Up Times to display in squares //////////////////////////////////////////////////////
//            if viewModel.isCalculatingOptimalWakeTimes {
//                Color.black.opacity(0.8).ignoresSafeArea()
//                VStack(spacing: 20) {
//                    VStack {
//                        Text("Please Select Wake Up Time:")
//                            .font(.headline)
//                            .bold()
//                        
//                        Text("You are Sleeping at \(viewModel.selectedTimeToSleep, formatter: DateFormatter.timeOnly)")
//                            .font(.subheadline)
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(10)
//                    
//                    HStack(spacing: 20) {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(
//                                LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                            )
//                            .frame(width: 150, height: 150)
//                            .overlay(
//                                VStack {
//                                    Text("\(viewModel.showLeftWakeTimes ? viewModel.suggestedWakeTimes[0].addingTimeInterval(-4.5 * 3600) : (viewModel.showRightWakeTimes ? viewModel.suggestedWakeTimes[0].addingTimeInterval(4.5 * 3600) : viewModel.suggestedWakeTimes[0]), formatter: DateFormatter.timeOnly)")
//                                        .foregroundColor(.white)
//                                        .font(.title)
//                                        .bold()
//                                    Text("\(viewModel.showLeftWakeTimes ? "1.5" : (viewModel.showRightWakeTimes ? "10.5" : "6")) hours of sleep")
//                                        .foregroundColor(.white)
//                                        .font(.headline)
//                                }
//                            )
//                            .onTapGesture {
//                                if viewModel.showLeftWakeTimes == true{
//                                    viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[0].addingTimeInterval(-4.5 * 3600)
//                                }
//                                else if viewModel.showRightWakeTimes == true{
//                                    viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[0].addingTimeInterval(4.5 * 3600)
//                                }
//                                else {
//                                    viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[0]
//                                }
//                                viewModel.showingPopup = true
//                            }
//                        
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(
//                                LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                            )
//                            .frame(width: 150, height: 150)
//                            .overlay(
//                                VStack {
//                                    Text("\(viewModel.showLeftWakeTimes ? viewModel.suggestedWakeTimes[1].addingTimeInterval(-4.5 * 3600) : (viewModel.showRightWakeTimes ? viewModel.suggestedWakeTimes[1].addingTimeInterval(4.5 * 3600) : viewModel.suggestedWakeTimes[1]), formatter: DateFormatter.timeOnly)")
//                                        .foregroundColor(.white)
//                                        .font(.title)
//                                        .bold()
//                                    Text("\(viewModel.showLeftWakeTimes ? "3" : (viewModel.showRightWakeTimes ? "12" : "7.5")) hours of sleep")
//                                        .foregroundColor(.white)
//                                        .font(.headline)
//                                }
//                            )
//                            .onTapGesture {
//                                if viewModel.showLeftWakeTimes == true{
//                                    viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[1].addingTimeInterval(-4.5 * 3600)
//                                }
//                                else if viewModel.showRightWakeTimes == true{
//                                    viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[1].addingTimeInterval(4.5 * 3600)
//                                }
//                                else {
//                                    viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[1]
//                                }
//                                viewModel.showingPopup = true
//                            }
//                    }
//                    
//                    if viewModel.suggestedWakeTimes.count >= 3 {
//                        HStack(spacing: 20) {
//                            Image(systemName: "arrow.left")
//                                .foregroundColor(viewModel.showLeftWakeTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (viewModel.preferences.antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
//                                .font(Font.system(size: 50))
//                                .bold()
//                                .onTapGesture {
//                                    if viewModel.showLeftWakeTimes == false && viewModel.showRightWakeTimes == false{
//                                        viewModel.showLeftWakeTimes = true
//                                    }
//                                    else if viewModel.showLeftWakeTimes == false && viewModel.showRightWakeTimes == true{
//                                        viewModel.showRightWakeTimes = false
//                                    }
//                                }
//                            
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(
//                                    LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                                )
//                                .frame(width: 150, height: 150)
//                                .overlay(
//                                    VStack {
//                                        Text("\(viewModel.showLeftWakeTimes ? viewModel.suggestedWakeTimes[2].addingTimeInterval(-4.5 * 3600) : (viewModel.showRightWakeTimes ? viewModel.suggestedWakeTimes[2].addingTimeInterval(4.5 * 3600) : viewModel.suggestedWakeTimes[2]), formatter: DateFormatter.timeOnly)")
//                                            .foregroundColor(.white)
//                                            .font(.title)
//                                            .bold()
//                                        Text("\(viewModel.showLeftWakeTimes ? "4.5" : (viewModel.showRightWakeTimes ? "13.5" : "9")) hours of sleep")
//                                            .foregroundColor(.white)
//                                            .font(.headline)
//                                    }
//                                )
//                                .onTapGesture {
//                                    if viewModel.showLeftWakeTimes == true{
//                                        viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[2].addingTimeInterval(-4.5 * 3600)
//                                    }
//                                    else if viewModel.showRightWakeTimes == true{
//                                        viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[2].addingTimeInterval(4.5 * 3600)
//                                    }
//                                    else {
//                                        viewModel.selectedTimeToWake = viewModel.suggestedWakeTimes[2]
//                                    }
//                                    viewModel.showingPopup = true
//                                }
//                            Image(systemName: "arrow.right")
//                                .foregroundColor(viewModel.showRightWakeTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (viewModel.preferences.antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
//                                .font(Font.system(size: 50))
//                                .bold()
//                                .onTapGesture {
//                                    if viewModel.showLeftWakeTimes == false && viewModel.showRightWakeTimes == false{
//                                        viewModel.showRightWakeTimes = true
//                                    }
//                                    else if viewModel.showLeftWakeTimes == true && viewModel.showRightWakeTimes == false{
//                                        viewModel.showLeftWakeTimes = false
//                                    }
//                                }
//                        }
//                    }
//                }
//                .alert(isPresented: $viewModel.showingPopup) {
//                    let formatter = DateFormatter()
//                    formatter.timeStyle = .short
//                    return Alert(title: Text("Manual Alarm Set"),
//                                 message: Text("""
//                                              Sleep Time - \(formatter.string(from: viewModel.selectedTimeToSleep))
//                                              Wake Time - \(formatter.string(from: viewModel.selectedTimeToWake))
//                                              
//                                              Have a goodnight!
//                                              """),
//                                 dismissButton: .default(Text("OK")) {
//                        viewModel.isCalculatingOptimalSleepTimes = false
//                                    viewModel.alarmSet = true
//                                    presentationMode.wrappedValue.dismiss()
//                                 })
//                }
//                
//// Inputted Wake Time, Calculating Optimal Sleep Times to display in squares //////////////////////////////////////////////////////
//            } else if viewModel.isCalculatingOptimalSleepTimes {
//                Color.black.opacity(0.8).ignoresSafeArea()
//                VStack(spacing: 20) {
//                    VStack {
//                        Text("Please Select Sleep Time:")
//                            .font(.headline)
//                            .bold()
//                        
//                        Text("You are Waking at \(viewModel.selectedTimeToWake, formatter: DateFormatter.timeOnly)")
//                            .font(.subheadline)
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(10)
//                    
//                    HStack(spacing: 20) {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(
//                                LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                            )
//                            .frame(width: 150, height: 150)
//                            .overlay(
//                                VStack {
//                                    Text("\(viewModel.showLeftSleepTimes ? viewModel.suggestedSleepTimes[0].addingTimeInterval(4.5 * 3600) : (viewModel.showRightSleepTimes ? viewModel.suggestedSleepTimes[0].addingTimeInterval(-4.5 * 3600) : viewModel.suggestedSleepTimes[0]), formatter: DateFormatter.timeOnly)")
//                                        .foregroundColor(.white)
//                                        .font(.title)
//                                        .bold()
//                                    Text("\(viewModel.showLeftSleepTimes ? "1.5" : (viewModel.showRightSleepTimes ? "10.5" : "6")) hours of sleep")
//                                        .foregroundColor(.white)
//                                        .font(.headline)
//                                }
//                            )
//                            .onTapGesture {
//                                if viewModel.showLeftSleepTimes == true{
//                                    viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[0].addingTimeInterval(4.5 * 3600)
//                                }
//                                else if viewModel.showRightSleepTimes == true{
//                                    viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[0].addingTimeInterval(-4.5 * 3600)
//                                }
//                                else {
//                                    viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[0]
//                                }
//                                viewModel.showingPopup = true
//                            }
//                        
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(
//                                LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                            )
//                            .frame(width: 150, height: 150)
//                            .overlay(
//                                VStack {
//                                    Text("\(viewModel.showLeftSleepTimes ? viewModel.suggestedSleepTimes[1].addingTimeInterval(4.5 * 3600) : (viewModel.showRightSleepTimes ? viewModel.suggestedSleepTimes[1].addingTimeInterval(-4.5 * 3600) : viewModel.suggestedSleepTimes[1]), formatter: DateFormatter.timeOnly)")
//                                        .foregroundColor(.white)
//                                        .font(.title)
//                                        .bold()
//                                    Text("\(viewModel.showLeftSleepTimes ? "3" : (viewModel.showRightSleepTimes ? "12" : "7.5")) hours of sleep")
//                                        .foregroundColor(.white)
//                                        .font(.headline)
//                                }
//                            )
//                            .onTapGesture {
//                                if viewModel.showLeftSleepTimes == true{
//                                    viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[1].addingTimeInterval(4.5 * 3600)
//                                }
//                                else if viewModel.showRightSleepTimes == true{
//                                    viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[1].addingTimeInterval(-4.5 * 3600)
//                                }
//                                else {
//                                    viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[1]
//                                }
//                                viewModel.showingPopup = true
//                            }
//                    }
//                    
//                    if viewModel.suggestedSleepTimes.count >= 3 {
//                        HStack(spacing: 20) {
//                            Image(systemName: "arrow.left")
//                                .foregroundColor(viewModel.showLeftSleepTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (viewModel.preferences.antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
//                                .font(Font.system(size: 50))
//                                .bold()
//                                .onTapGesture {
//                                    withAnimation {
//                                        if viewModel.showLeftSleepTimes == false && viewModel.showRightSleepTimes == false{
//                                            viewModel.showLeftSleepTimes = true
//                                        }
//                                        else if viewModel.showLeftSleepTimes == false && viewModel.showRightSleepTimes == true{
//                                            viewModel.showRightSleepTimes = false
//                                        }
//                                    }
//                                }
//                            
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(
//                                    LinearGradient(gradient: Gradient(colors: viewModel.preferences.antiBlueLightMode ? [Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8688587307, green: 0.5466106903, blue: 0, alpha: 1))] : [Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1558200947, blue: 0.502416709, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                                )
//                                .frame(width: 150, height: 150)
//                                .overlay(
//                                    VStack {
//                                        Text("\(viewModel.showLeftSleepTimes ? viewModel.suggestedSleepTimes[2].addingTimeInterval(4.5 * 3600) : (viewModel.showRightSleepTimes ? viewModel.suggestedSleepTimes[2].addingTimeInterval(-4.5 * 3600) : viewModel.suggestedSleepTimes[2]), formatter: DateFormatter.timeOnly)")
//                                            .foregroundColor(.white)
//                                            .font(.title)
//                                            .bold()
//                                        Text("\(viewModel.showLeftSleepTimes ? "4.5" : (viewModel.showRightSleepTimes ? "13.5" : "9")) hours of sleep")
//                                            .foregroundColor(.white)
//                                            .font(.headline)
//                                    }
//                                )
//                                .onTapGesture {
//                                    if viewModel.showLeftSleepTimes == true{
//                                        viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[2].addingTimeInterval(4.5 * 3600)
//                                    }
//                                    else if viewModel.showRightSleepTimes == true{
//                                        viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[2].addingTimeInterval(-4.5 * 3600)
//                                    }
//                                    else {
//                                        viewModel.selectedTimeToSleep = viewModel.suggestedSleepTimes[2]
//                                    }
//                                    viewModel.showingPopup = true
//                                }
//                            
//                            Image(systemName: "arrow.right")
//                                .foregroundColor(viewModel.showRightSleepTimes ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 0)) : (viewModel.preferences.antiBlueLightMode ? Color(#colorLiteral(red: 0.8527789558, green: 0.7426737457, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0.7542739527, blue: 1, alpha: 1))))
//                                .font(Font.system(size: 50))
//                                .bold()
//                                .onTapGesture {
//                                    withAnimation {
//                                        if viewModel.showLeftSleepTimes == false && viewModel.showRightSleepTimes == false{
//                                            viewModel.showRightSleepTimes = true
//                                        }
//                                        else if viewModel.showLeftSleepTimes == true && viewModel.showRightSleepTimes == false{
//                                            viewModel.showLeftSleepTimes = false
//                                        }
//                                    }
//                                }
//                        }
//                    }
//                }
//                .alert(isPresented: $viewModel.showingPopup) {
//                    let formatter = DateFormatter()
//                    formatter.timeStyle = .short
//                    return Alert(title: Text("Manual Alarm Set"),
//                         message: Text("""
//                                      Sleep Time - \(formatter.string(from: viewModel.selectedTimeToSleep))
//                                      Wake Time - \(formatter.string(from: viewModel.selectedTimeToWake))
//                                      
//                                      Have a goodnight!
//                                      """),
//                         dismissButton: .default(Text("OK")) {
//                        viewModel.isCalculatingOptimalSleepTimes = false
//                        viewModel.alarmSet = true
//                            presentationMode.wrappedValue.dismiss()
//                         })
//                }
            //}
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
            
            if calendar.isDate(currentTime, equalTo: selectedTime, toGranularity: .minute) {
                if viewModel.alarmSet == true{
                    viewModel.playAlarmSound()
                    viewModel.alarmSet = false
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
