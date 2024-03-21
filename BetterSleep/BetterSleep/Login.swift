import SwiftUI

struct Login: View {
    @Binding var showingLogin: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var shouldNavigateToContentView = false

    var body: some View {
        NavigationView {
            ZStack {
                SunView()
                
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.6), Color.green.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
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
    @State private var originalOffsets: [(CGFloat, CGFloat)] = []

    var body: some View {
        GeometryReader { geometry in
            let xOffset = (geometry.size.width / 2) - 550
            let yOffset = (geometry.size.height / 2) - 650

            ZStack {
                ForEach(0..<self.opacityValues.count, id: \.self) { index in
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: self.circleSizes(index), height: self.circleSizes(index))
                        .offset(x: self.originalOffsets.isEmpty ? xOffset : self.originalOffsets[index].0, y: self.originalOffsets.isEmpty ? yOffset : self.originalOffsets[index].1)
                        .opacity(self.opacityValues[index])
                        .animation(
                            Animation.easeInOut(duration: 2.5)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2)
                        )
               }
           }
       }
   }

   private func circleSizes(_ index: Int) -> CGFloat {
       let sizes: [CGFloat] = [760, 440, 280, 200, 140]
       return sizes[index]
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
