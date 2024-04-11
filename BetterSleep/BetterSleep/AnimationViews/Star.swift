//
//  Star.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
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
