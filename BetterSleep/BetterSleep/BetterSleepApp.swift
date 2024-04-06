//
//  BetterSleepApp.swift
//  BetterSleep
//
//  Created by Omar Al dulaimi on 2024-03-02.
//

import SwiftUI
import FirebaseCore

@main
struct BetterSleepApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LogInOrSignUpView()
                .preferredColorScheme(.dark)
        }
    }
}
