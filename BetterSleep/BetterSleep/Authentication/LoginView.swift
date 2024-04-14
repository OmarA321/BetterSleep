import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    @Binding var showingLogin: Bool
    
    //TODO: move all logic to viewmodel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var shouldNavigateToContentView = false

    var body: some View {
        NavigationView {
            ZStack {
                ForEach(0..<30) { _ in
                    ColourStar(colour: .green)
                }
                
                SunView()

                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                    .mask(WavyHills())
                    .frame(height: 150)
                    .offset(y: UIScreen.main.bounds.height * 0.4)



                VStack(spacing: 20) {
                    Spacer()
                    Text("BetterSleep")
                        .font(Font.custom("Snell Roundhand", size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.purple)
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                    
                    Text("Improve your sleep cycle")
                        .foregroundColor(Color.gray)
                        .font(.headline)
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                    
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .padding(.horizontal, 40)
                        )
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
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
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                        
                    
                    Button(action: {
                        viewModel.login { success in
                            if success {
                                self.shouldNavigateToContentView = true
                            } else {
                                // Optionally handle error, such as displaying a message
                            }
                        }
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .shadow(color: Color.black, radius: 3, x: 2, y: 2)
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
                        Text("Don't have an account?")
                            .foregroundColor(Color.gray)
                            .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                        Button("Sign Up") {
                            withAnimation {
                                showingLogin = false
                            }
                        }
                        .fontWeight(.bold)
                        .foregroundColor(Color.green)
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
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
