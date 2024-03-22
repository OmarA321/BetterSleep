//
//  ContentView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import SwiftUI

struct Star {
    @Binding var antiBlueLightMode: Bool
    var offset: CGSize = CGSize(width: CGFloat.random(in: 0...500), height: CGFloat.random(in: -500...500))
    var delay: Double = Double.random(in: 0...5)
    var speed: Double = Double.random(in: 5...15)
    var color: Color {
        if antiBlueLightMode {
            let colors: [Color] = [.yellow, .orange, .red]
            return colors.randomElement() ?? .white
        } else {
            let colors: [Color] = [.blue, .green, .purple]
            return colors.randomElement() ?? .white
        }
    }
    init(antiBlueLightMode: Binding<Bool>) {
        self._antiBlueLightMode = antiBlueLightMode
    }
}

struct ShootingStarsAnimation: View {
    @Binding var stars: [Star]
    @Binding var disableStars: Bool
    @Binding var antiBlueLightMode: Bool
    
    var body: some View {
        ZStack {
            ForEach(stars.indices, id: \.self) { index in
                if !disableStars {
                    Image(systemName: "star.fill")
                        .foregroundColor(stars[index].color)
                        .offset(stars[index].offset)
                        .onAppear {
                            animateStar(index: index)
                        }
                }
            }
        }
        .onChange(of: disableStars) { newValue in
            if !newValue {
                regenerateStars()
            }
        }
    }

    private func animateStar(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + stars[index].delay) {
            withAnimation(.easeInOut(duration: stars[index].speed)) {
                stars[index].offset = CGSize(width: -500, height: CGFloat.random(in: -500...500))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + stars[index].speed) {
                resetStar(index: index)
            }
        }
    }

    private func resetStar(index: Int) {
        stars[index].offset = CGSize(width: CGFloat.random(in: 0...500), height: CGFloat.random(in: -500...500))
        animateStar(index: index)
    }
    
    private func regenerateStars() {
        stars.removeAll()
        for _ in 0..<25 {
            stars.append(Star(antiBlueLightMode: $antiBlueLightMode))
        }
    }
}

struct ContentView: View {
    @State private var stars: [Star] = []
    @State private var currentTime = Date()
    @State private var disableStars = false
    @State private var antiBlueLightMode = false
    
    @State private var selectedTimeToSleep = Date()
    @State private var selectedTimeToWake = Date()
    @State private var alarmSet = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<30) { _ in
                BlueStar()
            }
            
            VStack {
                ShootingStarsAnimation(stars: $stars, disableStars: $disableStars, antiBlueLightMode: $antiBlueLightMode)
                ZStack {
                    
                    Text("BetterSleep")
                        .font(Font.custom("Snell Roundhand", size: 40))
                        .fontWeight(.heavy)
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: SettingsView(disableStars: $disableStars, antiBlueLightMode: $antiBlueLightMode)) {
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
                
                Text("Current Time:")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                
                Text("\(currentTime, formatter: dateFormatter)")
                    .font(.largeTitle)
                
                Spacer()
                
                NavigationLink(destination: SleepRecommendationView(antiBlueLightMode: $antiBlueLightMode)) {
                    Text("SleepRecommendations")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                    Image(systemName: "moon.haze.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(LinearGradient(gradient: Gradient(colors: [antiBlueLightMode ? .red : .purple, antiBlueLightMode ? .yellow : .blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                NavigationLink(destination: SmartAlarmView(antiBlueLightMode: $antiBlueLightMode, selectedTimeToWake: $selectedTimeToWake, selectedTimeToSleep: $selectedTimeToSleep, alarmSet: $alarmSet)) {
                    Text("Smart Alarm")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                    Image(systemName: "alarm.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(LinearGradient(gradient: Gradient(colors: [antiBlueLightMode ? .yellow : .blue, antiBlueLightMode ? .orange : .green]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                
                NavigationLink(destination: SleepAnalysisView(antiBlueLightMode: $antiBlueLightMode)) {
                    Text("Sleep History & Analysis")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                    Image(systemName: "bed.double.fill")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(LinearGradient(gradient: Gradient(colors: [antiBlueLightMode ? .orange : .green, antiBlueLightMode ? .red : .purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .onAppear {
                if stars.isEmpty {
                    generateStars()
                }
            }
            .onReceive(timer) { _ in
                self.currentTime = Date()
            }
            .onChange(of: antiBlueLightMode) { _ in
                regenerateStars()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private func generateStars() {
        for _ in 0..<25 {
            stars.append(Star(antiBlueLightMode: $antiBlueLightMode))
        }
    }
    
    private func regenerateStars() {
        stars.removeAll()
        for _ in 0..<25 {
            stars.append(Star(antiBlueLightMode: $antiBlueLightMode))
        }
    }
}
