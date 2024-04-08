//
//  SleepRecommendationViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-07.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class SleepRecommendationViewModel: ObservableObject {
    
    //TODO: add publisher to avoid warnings updating these variables in function
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    @Published var recommendations: [Recommendation] = []
    private var user: User = User(id: "", username: "", email: "", sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timetoWake: nil)
    
    init() {
    }
    
    //TODO: move all database functions to FireDBHelper
    func fetchUser() async {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        print(#function, "attempting to log in user id \(userId)")
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userId)
        
        do {
            self.user = try await docRef.getDocument(as: User.self)
            self.preferences = self.user.preferences
            self.recommendations = self.user.recommendations
            print("user: \(self.user)")
        } catch {
            print("error decoding user \(error)")
        }
        
    }
        

}
    
    


