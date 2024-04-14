import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    
    @Binding var showingLogin: Bool
    
    //TODO: move all logic to viewmodel
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var shouldNavigateToContentView = false

    var body: some View {
        NavigationView {
            ZStack {
                ForEach(0..<30) { _ in
                    ColourStar(colour: .purple)
                }
                
                SunView2()
                
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                    .mask(WavyHills())
                    .frame(height: 150)
                    .offset(y: UIScreen.main.bounds.height * 0.4)
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("Join  ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.green) +
                    Text("BetterSleep")
                        .font(Font.custom("Snell Roundhand", size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.green)
                    
                    Group {
                        TextField("Username", text: $viewModel.username)
                            .padding()
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .padding(.horizontal, 40)
                            )
                            .autocapitalization(.none)
                        
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .padding(.horizontal, 40)
                            )
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $viewModel.password)
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
                        
                        viewModel.register()
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                    NavigationLink(destination: MainMenuView()
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
                            withAnimation {
                                showingLogin = true
                            }
                        }
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                    }
                }
            }
            .alert(isPresented: $viewModel.isShowingError){
                return Alert(title: Text("Error"),
                             message: Text(viewModel.errorMessage),
                             dismissButton: .default(Text("OK"))
                             )
            }
        }
    }
}
