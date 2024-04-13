import SwiftUI

struct SleepRecommendationView: View {
    @StateObject var viewModel = SleepRecommendationViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "moon.haze.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
                    .foregroundColor(viewModel.preferences.antiBlueLightMode ? Color(red: 1.0, green: 0.4, blue: 0.4) : Color.purple)
                    .padding()
                
                Text("Sleep Recommendations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .padding(.top, -10)
                
                Text("Based on your sleep patterns, we recommend the following:")
                    .font(.body)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                
                // Use the user's times to sleep and wake up if available
                if let timeToSleep = viewModel.timeToSleep,
                           let timeToWake = viewModel.timeToWake {
                            sleepTimesView(timeToSleep: timeToSleep, timeToWake: timeToWake)
                        }
                
                Text("Additional Recommendations:")
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                // Recommendations list updated by the ViewModel
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.recommendations, id: \.self) { recommendation in
                        RecommendationRow(antiBlueLightMode: viewModel.preferences.antiBlueLightMode, title: recommendation.title, description: recommendation.description)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Spacer()
                
                Divider().padding(.horizontal, 20)
                
                Text("These recommendations are based on your individual sleep patterns and aim to optimize your sleep quality and overall well-being.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
            }
        }
    }
    
    @ViewBuilder
    private func sleepTimesView(timeToSleep: Date, timeToWake: Date) -> some View {
        HStack {
            timeView(title: "Time to Sleep", time: timeToSleep)
            Spacer()
            timeView(title: "Time to Wake Up", time: timeToWake)
        }
        .padding(.horizontal, 20)
    }
    
    private func timeView(title: String, time: Date) -> some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(time, style: .time)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(viewModel.preferences.antiBlueLightMode ? Color(red: 1.0, green: 0.4, blue: 0.4) : Color.purple)
        )
    }
}

