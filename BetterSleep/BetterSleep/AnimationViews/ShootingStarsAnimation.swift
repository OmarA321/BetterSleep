//
//  ShootingStars.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

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
