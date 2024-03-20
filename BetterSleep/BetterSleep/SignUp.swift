import SwiftUI

struct SignUp: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var shouldNavigateToContentView = false


    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                Spacer()
                Text("Join BetterSleep")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                
                Group {
                    TextField("Username", text: $username)
                        .padding()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .padding(.horizontal, 40)
                        )
                    
                    TextField("Email", text: $email)
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
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .padding(.horizontal, 40)
                        )
                }

                Button(action: {
                    self.shouldNavigateToContentView = true
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
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
                    Text("Already have an account?")
                        .foregroundColor(Color.gray)
                    Button("Login") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                }
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
