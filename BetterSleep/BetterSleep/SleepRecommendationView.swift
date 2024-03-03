import SwiftUI

struct SleepRecommendationView: View {
    var body: some View {
        ScrollView {
            VStack {
                
                
                Image(systemName: "moon.stars")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("Sleep Recommendation")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("Based on your sleep patterns, we recommend the following:")
                    .font(.body)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("Time to Sleep")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("10:00 PM")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("Time to Wake Up")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("6:00 AM")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Text("Additional Recommendations:")
                    .font(.headline)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    RecommendationRow(title: "Avoid Caffeine", description: "Try to avoid caffeine intake at least 6 hours before your recommended sleep time.")
                    RecommendationRow(title: "Create a Bedtime Routine", description: "Establish a relaxing bedtime routine to signal to your body that it's time to wind down.")
                    RecommendationRow(title: "Limit Screen Time", description: "Reduce exposure to screens and bright lights at least an hour before bedtime to promote better sleep.")
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Text("These recommendations are based on your individual sleep patterns and aim to optimize your sleep quality and overall well-being.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct RecommendationRow: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            Text(description)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
}

struct SleepRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        SleepRecommendationView()
    }
}
