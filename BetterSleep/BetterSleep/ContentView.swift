import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "bed.double.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.purple)
                
                Spacer()
                
                NavigationLink(destination: SleepRecommendationView()) {
                    Text("Sleep Recommendation")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SmartAlarmView()) {
                    Text("Smart Alarm")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SleepAnalysisView()) {
                    Text("Sleep Analysis")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("BetterSleep")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
