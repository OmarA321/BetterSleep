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
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    @Published var recommendations: [Recommendation] = []
    @Published var selectedDate = Date()
    @Published var sleepTime = Date()
    @Published var wakeUpTime = Date()
    @Published var selectedSleepQuality = "Great"
    
    let sleepQualityOptions = ["Great", "Good", "Okay", "Poor", "Awful"]
    
    // TODO: move this to new viewmodel for ViewPersonalSleepHistory
    @Published var sleepHistory: [SleepRecord] = []
    
    private var fireDBHelper: FireDBHelper
    
    private var user: User = User(id: "", username: "", email: "", sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timeToWake: nil)
    
    init() {
        self.fireDBHelper = FireDBHelper()
    }
    
    func fetchUser() async {
        
        await fireDBHelper.fetchUser()
        
        DispatchQueue.main.async {
            self.user = self.fireDBHelper.user!
            self.preferences = self.user.preferences
            self.recommendations = self.user.recommendations
        }
        
        print(#function, "user: \(String(describing: self.user))")
        
    }
    
    func addUserSleepRecord() async {
        
        let hoursSlept = self.wakeUpTime.timeIntervalSince(self.sleepTime)
        
        let newSleepRecord = SleepRecord(date: self.selectedDate, hoursSlept: hoursSlept, qualityRating: self.selectedSleepQuality)
        
        self.user.sleepHistory.append(newSleepRecord)
        
        await fireDBHelper.addUserSleepRecord(sleepRecord: newSleepRecord)
    
    }
        

}
