//
//  ColourStar.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct ColourStar: View {
    var colour: Color
    
    var body: some View {
        let size = CGFloat.random(in: 1...3)
        let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
        let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        
        return Circle()
            .foregroundColor(colour)
            .frame(width: size, height: size)
            .position(x: x, y: y)
    }
}

