//
//  LogInOrSignUpView.swift
//  BetterSleep
//
//  Created by Elias Alissandratos on 2024-03-20.
//

import SwiftUI

struct LogInOrSignUpView: View {
    @State private var showingLogin = true

    var body: some View {
        if showingLogin {
            Login(showingLogin: $showingLogin)
                .transition(.slide)
        } else {
            SignUp(showingLogin: $showingLogin)
                .transition(.slide)
        }
    }
}
