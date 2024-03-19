import SwiftUI

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var shouldNavigateToContentView = false // State for navigation control

    var body: some View {
        NavigationView { // Navigation support
            ZStack {
                Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("BetterSleep")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                    
                    Text("Improve your sleep cycle")
                        .foregroundColor(Color.gray)
                        .font(.headline)
                    
                    TextField("Username", text: $username)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    Button(action: {
                        // Trigger navigation
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
                    
                    // NavigationLink to trigger programmatic navigation
                    NavigationLink(destination: ContentView()
                        .preferredColorScheme(.dark)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true), // Additional attempt to remove space
                        isActive: $shouldNavigateToContentView) {
                        EmptyView()
                    }


                    Spacer()
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(Color.gray)
                        
                        NavigationLink(destination: SignUp().preferredColorScheme(.dark)) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                        }
                    }
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
