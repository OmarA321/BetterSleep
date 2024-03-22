import SwiftUI

struct SignUp: View {
    @Binding var showingLogin: Bool
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var shouldNavigateToContentView = false

    var body: some View {
        NavigationView {
            ZStack {
                ForEach(0..<30) { _ in
                    PurpleStar()
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
                            .background(Color.green)
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
                            withAnimation {
                                showingLogin = true
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

struct SunView2: View {
    @State private var opacityValues: [Double] = [0.1, 0.1, 0.25, 0.5, 0.75]
    let animationDuration: TimeInterval = 1.5
    
    var body: some View {
        GeometryReader { geometry in
            let xOffset = (geometry.size.width / 2) - 200
            let yOffset = (geometry.size.height / 2) - 650

            ZStack {
                ForEach(0..<self.opacityValues.count, id: \.self) { index in
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black, Color.blue]),
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .frame(width: self.circleSizes(index), height: self.circleSizes(index))
                        .offset(x: xOffset, y: yOffset)
                        .opacity(self.opacityValues[index])
                }
            }
        }
        .onAppear {
            self.startOpacityAnimation()
        }
    }

    private func circleSizes(_ index: Int) -> CGFloat {
        let sizes: [CGFloat] = [760, 440, 280, 200, 140]
        return sizes[index]
    }
    
    private func startOpacityAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            withAnimation(.linear(duration: animationDuration)) {
                if self.opacityValues == [0.6, 0.4, 0.2, 0.8, 0.9] {
                    self.opacityValues = [0.1, 0.1, 0.25, 0.5, 0.75]
                } else {
                    self.opacityValues = [0.6, 0.4, 0.2, 0.8, 0.9]
                }
            }
        }
    }
}
