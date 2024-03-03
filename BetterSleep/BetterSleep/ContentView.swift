import SwiftUI

struct ShootingStarsAnimation: View {
    @Binding var stars: [Star]
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            ForEach(stars.indices, id: \.self) { index in
                Image(systemName: "star.fill")
                    .foregroundColor(.purple)
                    .offset(stars[index].offset)
                    .onAppear {
                        animateStar(index: index)
                    }
            }
        }
    }
    
    private func animateStar(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + stars[index].delay) {
            withAnimation(.easeInOut(duration: stars[index].speed)) {
                stars[index].offset = CGSize(width: -500, height: CGFloat.random(in: -500...500))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + stars[index].speed) {
                resetStar(index: index)
            }
        }
    }
    
    private func resetStar(index: Int) {
        withAnimation {
            stars[index].offset = CGSize(width: CGFloat.random(in: 0...500), height: CGFloat.random(in: -500...500))
            animateStar(index: index)
        }
    }
}

struct Star {
    var offset: CGSize = CGSize(width: CGFloat.random(in: 0...500), height: CGFloat.random(in: -500...500))
    var delay: Double = Double.random(in: 0...5)
    var speed: Double = Double.random(in: 5...10)
}

struct ContentView: View {
    @State private var stars: [Star] = []
    @State private var currentTime = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ShootingStarsAnimation(stars: $stars) // Pass stars state
                
                Image(systemName: "moon.zzz.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.indigo)
                    .padding()
                
                Spacer()
                
                Text("Current Time:")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                
                Text("\(currentTime, formatter: dateFormatter)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: SleepRecommendationView()) {
                    Text("Get Sleep Recommendations")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 30)
                }
                
                NavigationLink(destination: SmartAlarmView()) {
                    Text("Smart Alarm")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 30)
                }
                
                NavigationLink(destination: SleepAnalysisView()) {
                    Text("View Sleep Analysis")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 30)
                }
                
                Spacer()
            }
            .navigationTitle("BetterSleep")
            .onAppear {
                if stars.isEmpty {
                    // Generate stars when view appears if stars array is empty
                    generateStars()
                }
            }
            .onReceive(timer) { _ in
                self.currentTime = Date()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func generateStars() {
        // Generate stars
        for _ in 0..<20 {
            stars.append(Star())
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
