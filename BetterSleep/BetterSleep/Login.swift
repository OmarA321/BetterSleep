import SwiftUI

struct Login: View {
    @Binding var showingLogin: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var shouldNavigateToContentView = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    Text("BetterSleep")
                        .font(Font.custom("Snell Roundhand", size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.purple)
                    
                    Text("Improve your sleep cycle")
                        .foregroundColor(Color.gray)
                        .font(.headline)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .padding(.horizontal, 40)
                        )
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .padding(.horizontal, 40)
                        )
                    
                    Button(action: {
                        self.shouldNavigateToContentView = true
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                    
                    NavigationLink(destination: ContentView()
                        .preferredColorScheme(.dark)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true),
                        isActive: $shouldNavigateToContentView) {
                        EmptyView()
                    }

                    Spacer()
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(Color.gray)
                        Button("Sign Up") {
                            withAnimation {
                                showingLogin = false
                            }
                        }
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                    }
                }
            }
        }
    }
}
