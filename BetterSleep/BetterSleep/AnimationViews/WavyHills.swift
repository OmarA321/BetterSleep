//
//  WavyHills.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-11.
//

import SwiftUI

struct WavyHills: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height
        path.move(to: CGPoint(x: 0, y: height * 0.5))
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.3),
                      control1: CGPoint(x: width * 0.25, y: height * 0.6),
                      control2: CGPoint(x: width * 0.25, y: height * 0.4))
        path.addCurve(to: CGPoint(x: width, y: height * 0.5),
                      control1: CGPoint(x: width * 0.75, y: height * 0.2),
                      control2: CGPoint(x: width * 0.75, y: height * 0.6))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()

        return path
    }
}
