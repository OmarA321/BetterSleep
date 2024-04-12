import SwiftUI

struct LogInOrSignUpView: View {
    @State private var showingLogin = true
    @State private var animate = true

    var body: some View {
        if showingLogin {
            LoginView(showingLogin: $showingLogin)
                .transition(.slide)
        } else {
            SignUpView(showingLogin: $showingLogin)
                .transition(.slide)
        }
    }
}
