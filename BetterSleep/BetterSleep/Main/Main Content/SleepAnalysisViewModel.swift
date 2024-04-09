//
//  SleepAnalysisViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-07.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class SleepAnalysisViewModel: ObservableObject {
    
    //TODO: add publisher to avoid warnings updating these variables in function
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    @Published var recommendations: [Recommendation] = []
    @Published var selectedDate = Date()
    @Published var sleepTime = Date()
    @Published var wakeUpTime = Date()
    @Published var selectedSleepQuality = "Great"
    
    let sleepQualityOptions = ["Great", "Good", "Okay", "Poor", "Awful"]
    
    // TODO: move this to new viewmodel for ViewPersonalSleepHistory
    @Published var sleepHistory: [SleepRecord] = []
    
    
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
            
            // TODO: move this to new viewmodel for ViewPersonalSleepHistory
            self.sleepHistory = self.user.sleepHistory
            
            print("user: \(self.user)")
        } catch {
            print("error decoding user \(error)")
        }
        
    }
    
    //TODO: move all database functions to FireDBHelper
    
    func addUserSleepRecord() async {
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(self.user.id!)
        
        let hoursSlept = self.wakeUpTime.timeIntervalSince(self.sleepTime)
        
        let newSleepRecord = SleepRecord(date: self.selectedDate, hoursSlept: hoursSlept, qualityRating: self.selectedSleepQuality)
        self.user.sleepHistory.append(newSleepRecord)
        
        do {
            try docRef.setData(from: self.user)
            print("Document successfully updated")
        } catch {
          print("Error updating document: \(error)")
        }
        
    
    }
        

}
