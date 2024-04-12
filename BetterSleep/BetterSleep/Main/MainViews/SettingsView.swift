//
//  SettingsView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos on 2024-03-03.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()

    
    init() {
        
    }
    
    var body: some View {
        ZStack{
            ForEach(0..<30) { _ in
                ColourStar(colour: .blue)
            }
            VStack(spacing: 20) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        viewModel.preferences.antiBlueLightMode ? LinearGradient(gradient: Gradient(colors: [.red, .yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [.purple, .blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .clipShape(Circle())
                
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Toggle("Disable Home Page Stars", isOn: $viewModel.preferences.disableStars)
                    .padding()
                
                Toggle("Anti Blue Light Mode", isOn: $viewModel.preferences.antiBlueLightMode)
                    .padding()
                
                Spacer()
                
            }
            .padding()
        }
        .onAppear(){
            Task {
                await viewModel.fetchUser()
            }
        }
        .onDisappear(){
            Task {
                await viewModel.updateUserPreferences()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
