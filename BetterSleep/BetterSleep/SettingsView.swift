//
//  SettingsView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos on 2024-03-03.
//

import SwiftUI

struct SettingsView: View {
    @Binding private var disableStars: Bool
    @Binding private var antiBlueLightMode: Bool
    
    init(disableStars: Binding<Bool>, antiBlueLightMode: Binding<Bool>) {
        self._disableStars = disableStars
        self._antiBlueLightMode = antiBlueLightMode
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gearshape.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 100)
                .foregroundColor(.white)
                .padding()
                .background(
                    antiBlueLightMode ? LinearGradient(gradient: Gradient(colors: [.red, .yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [.purple, .blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Circle())
            
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Toggle("Disable Home Page Stars", isOn: $disableStars)
                .padding()
            
            Toggle("Anti Blue Light Mode", isOn: $antiBlueLightMode)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(disableStars: .constant(false), antiBlueLightMode: .constant(false))
    }
}
