//
//  SunView2.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct SunView2: View {
    @State private var opacityValues: [Double] = [0.1, 0.1, 0.25, 0.5, 0.75]
    let animationDuration: TimeInterval = 1.5
    
    var body: some View {
        GeometryReader { geometry in
            let xOffset = (geometry.size.width / 2) - 200
            let yOffset = (geometry.size.height / 2) - 650

            ZStack {
                ForEach(0..<self.opacityValues.count, id: \.self) { index in
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black, Color.blue]),
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .frame(width: self.circleSizes(index), height: self.circleSizes(index))
                        .offset(x: xOffset, y: yOffset)
                        .opacity(self.opacityValues[index])
                }
            }
        }
        .onAppear {
            self.startOpacityAnimation()
        }
    }

    private func circleSizes(_ index: Int) -> CGFloat {
        let sizes: [CGFloat] = [760, 440, 280, 200, 140]
        return sizes[index]
    }
    
    private func startOpacityAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            withAnimation(.linear(duration: animationDuration)) {
                if self.opacityValues == [0.6, 0.4, 0.2, 0.8, 0.9] {
                    self.opacityValues = [0.1, 0.1, 0.25, 0.5, 0.75]
                } else {
                    self.opacityValues = [0.6, 0.4, 0.2, 0.8, 0.9]
                }
            }
        }
    }
}
