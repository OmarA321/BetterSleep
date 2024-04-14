//
//  ContentView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import SwiftUI


struct MainMenuView: View {
    
    @StateObject var viewModel = MainMenuViewModel()
    
    
    
    var body: some View {
        ZStack {
            ForEach(0..<30) { _ in
                ColourStar(colour: .blue)
            }
            
            VStack {
                ShootingStarsAnimation(stars: $viewModel.stars, disableStars: $viewModel.preferences.disableStars, antiBlueLightMode: $viewModel.preferences.antiBlueLightMode)
                ZStack {
                    
                    Text("BetterSleep")
                        .font(Font.custom("Snell Roundhand", size: 40))
                        .fontWeight(.heavy)
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: "moon.zzz.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 150)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                HStack(spacing: 20){
                    VStack{
                        Text("Current Time:")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        
                        Text("\(viewModel.currentTime, formatter: dateFormatter)")
                            .font(.largeTitle)
                    }

                    if viewModel.alarmSet{
                        Spacer()
                        VStack{
                            Text("Alarm Set:")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            
                            Text("\(viewModel.selectedTimeToWake, formatter: alarmFormatter)")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: SleepRecommendationView()) {
                    Text("SleepRecommendations")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                    Image(systemName: "moon.haze.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(LinearGradient(gradient: Gradient(colors: [viewModel.preferences.antiBlueLightMode ? .red : .purple, viewModel.preferences.antiBlueLightMode ? .yellow : .blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                NavigationLink(destination: SmartAlarmView()) {
                    Text("Smart Alarm")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                    Image(systemName: "alarm.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(LinearGradient(gradient: Gradient(colors: [viewModel.preferences.antiBlueLightMode ? .yellow : .blue, viewModel.preferences.antiBlueLightMode ? .orange : .green]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                
                NavigationLink(destination: SleepAnalysisView()) {
                    Text("Sleep History & Analysis")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                    Image(systemName: "bed.double.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(LinearGradient(gradient: Gradient(colors: [viewModel.preferences.antiBlueLightMode ? .orange : .green, viewModel.preferences.antiBlueLightMode ? .red : .purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .onAppear {
                if viewModel.stars.isEmpty {
                    generateStars()
                }
                Task {
                    await viewModel.fetchUser()
                }
                
            }
            .onReceive(viewModel.timer) { _ in
                viewModel.currentTime = Date()
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
            .onChange(of: viewModel.preferences.antiBlueLightMode) { _ in
                regenerateStars()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }
    
    private var alarmFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }
    
    func generateStars() {
        for _ in 0..<25 {
            viewModel.stars.append(Star(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode))
        }
    }
    
    func regenerateStars() {
        viewModel.stars.removeAll()
        for _ in 0..<25 {
            viewModel.stars.append(Star(antiBlueLightMode: $viewModel.preferences.antiBlueLightMode))
        }
    }
    
    
}
