//
//  PersonalSleepHistoryViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-14.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class PersonalSleepHistoryViewModel: ObservableObject {
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
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
            self.sleepHistory = self.user.sleepHistory
        }
        
        print(#function, "user: \(String(describing: self.user))")
        print(#function, "sleephistory: \(String(describing: self.sleepHistory))")
        
    }
        

}
