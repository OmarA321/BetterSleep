//
//  BetterSleepApp.swift
//  BetterSleep
//
//  Created by Omar Al dulaimi on 2024-03-02.
//

import SwiftUI
import FirebaseCore

extension BetterSleepApp {
  private func initFirebase() {
    FirebaseApp.configure()
  }
}


@main
struct BetterSleepApp: App {
    
    init() {
        initFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            LogInOrSignUpView()
                .preferredColorScheme(.dark)
        }
    }
}
