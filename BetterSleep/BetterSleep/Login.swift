import SwiftUI

struct Login: View {
    @Binding var showingLogin: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var shouldNavigateToContentView = false

    var body: some View {
        NavigationView {
            ZStack {
                ForEach(0..<30) { _ in
                    GreenStar()
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
                    
                    TextField("Username", text: $username)
                        .padding()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .padding(.horizontal, 40)
                        )
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                    
                    SecureField("Password", text: $password)
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
                            .shadow(color: Color.black, radius: 3, x: 2, y: 2)
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
                            .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                        Button("Sign Up") {
                            withAnimation {
                                showingLogin = false
                            }
                        }
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                        .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                    }
                }
            }
        }
    }
}

struct SunView: View {
    @State private var opacityValues: [Double] = [0.1, 0.1, 0.25, 0.5, 0.75]
    let animationDuration: TimeInterval = 1.5
    
    var body: some View {
        GeometryReader { geometry in
            let xOffset = (geometry.size.width / 2) - 550
            let yOffset = (geometry.size.height / 2) - 650

            ZStack {
                ForEach(0..<self.opacityValues.count, id: \.self) { index in
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.black]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
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

struct WavyHills: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height
        path.move(to: CGPoint(x: 0, y: height * 0.5))
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.3),
                      control1: CGPoint(x: width * 0.25, y: height * 0.6),
                      control2: CGPoint(x: width * 0.25, y: height * 0.4))
        path.addCurve(to: CGPoint(x: width, y: height * 0.5),
                      control1: CGPoint(x: width * 0.75, y: height * 0.2),
                      control2: CGPoint(x: width * 0.75, y: height * 0.6))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()

        return path
    }
}

struct BlueStar: View {
    var body: some View {
        let size = CGFloat.random(in: 1...3)
        let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
        let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        
        return Circle()
            .foregroundColor(.blue)
            .frame(width: size, height: size)
            .position(x: x, y: y)
    }
}

struct GreenStar: View {
    var body: some View {
        let size = CGFloat.random(in: 1...3)
        let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
        let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        
        return Circle()
            .foregroundColor(.green)
            .frame(width: size, height: size)
            .position(x: x, y: y)
    }
}

struct PurpleStar: View {
    var body: some View {
        let size = CGFloat.random(in: 1...3)
        let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
        let y = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        
        return Circle()
            .foregroundColor(.purple)
            .frame(width: size, height: size)
            .position(x: x, y: y)
    }
}
