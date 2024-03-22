import SwiftUI

struct LogInOrSignUpView: View {
    @State private var showingLogin = true
    @State private var animate = true

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
