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
    @Published var selectedSleepDate = Date()
    @Published var selectedWakeDate = Date()
    @Published var sleepTime = Date()
    @Published var wakeUpTime = Date()
    @Published var selectedSleepQuality = "Great"
    @Published var totalSleepRecords: Int = 0
    @Published var averageSleepDuration: Double = 0
    @Published var averageSleepQuality = ""
    
    let sleepQualityOptions = ["Great", "Good", "Okay", "Poor", "Awful"]
    
    private var totalSleepQualitySum: Int = 0
    private var totalHoursSlept: Double = 0
    
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
            self.totalSleepRecords = self.user.sleepHistory.count
            for record in self.user.sleepHistory {
                self.totalHoursSlept += record.hoursSlept
                self.totalSleepQualitySum += (self.sleepQualityOptions.firstIndex(of: record.qualityRating) ?? 0)
            }
            
            if self.totalSleepRecords > 0 {
                self.averageSleepDuration = self.totalHoursSlept / Double(self.totalSleepRecords)
                self.averageSleepQuality = self.sleepQualityOptions[Int(self.totalSleepQualitySum / self.totalSleepRecords)]
            }
            
        }
        
        print(#function, "user: \(String(describing: self.user))")
        
    }
    
    func addUserSleepRecord() async {
        
        let hoursSlept = self.sleepTime.distance(to: self.wakeUpTime) / 3600
        
        let newSleepRecord = SleepRecord(date: self.sleepTime, hoursSlept: hoursSlept, qualityRating: self.selectedSleepQuality)
        
        self.totalSleepRecords += 1;
        
        self.user.sleepHistory.append(newSleepRecord)
        
        await fireDBHelper.addUserSleepRecord(sleepRecord: newSleepRecord)
    
    }
        

}
