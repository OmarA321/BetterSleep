import Foundation
import FirebaseFirestore
import FirebaseAuth

class SleepRecommendationViewModel: ObservableObject {
    @Published var preferences: UserPreferences
    @Published var recommendations: [Recommendation]
    private var user: User
    var timeToSleep: Date? {
        user.timeToSleep
    }
    
    var timeToWake: Date? {
        user.timeToWake
    }
    
    init() {
        // Set initial values
        self.preferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
        self.recommendations = []
        self.user = User(username: "", email: "", sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timeToWake: nil)
        
        // Load user data
        Task {
            await fetchUser()
        }
    }
    
    func fetchUser() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userId)
        
        do {
            let userData = try await docRef.getDocument(as: User.self)
            DispatchQueue.main.async {
                self.user = userData
                self.preferences = self.user.preferences
                self.recommendations = self.user.recommendations
                
                // Update recommendations based on sleep history
                self.updateRecommendationsBasedOnSleepHistory()
            }
        } catch {
            print("Error decoding user: \(error)")
        }
    }
    
    private func updateRecommendationsBasedOnSleepHistory() {
        guard !user.sleepHistory.isEmpty else {
            recommendations.append(Recommendation(title: "No Sleep Data", description: "No sleep data available to generate recommendations. Please track your sleep to get personalized recommendations."))
            return
        }
        
        let averageHoursSlept = user.sleepHistory.map { $0.hoursSlept }.average()
        let poorSleepQualityDays = user.sleepHistory.filter { $0.qualityRating.lowercased() != "great" }.count
        
        var newRecommendations = [Recommendation]()
        
        if averageHoursSlept < 7 {
            newRecommendations.append(Recommendation(title: "Bad Sleep Duration", description: "Aim for at least 7 hours of sleep per night to feel rested and rejuvenated."))
        } else {
            newRecommendations.append(Recommendation(title: "Great Sleep Duration", description: "You're consistently getting a good amount of sleep. Keep it up!"))
        }
        
        if poorSleepQualityDays > user.sleepHistory.count / 2 {
            newRecommendations.append(Recommendation(title: "Bad Sleep Quality", description: "Consider relaxing activities before bed, such as reading or meditating, to improve sleep quality."))
        } else {
            newRecommendations.append(Recommendation(title: "Great Sleep Quality", description: "Your sleep quality is consistently great. Excellent job maintaining good sleep habits!"))
        }
        
        DispatchQueue.main.async {
            self.recommendations = newRecommendations
        }
    }
}

extension Array where Element: BinaryFloatingPoint {
    func average() -> Double {
        isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }
}
