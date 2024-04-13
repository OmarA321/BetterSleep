//
//  SettingsViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-07.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class SettingsViewModel: ObservableObject {
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    
    private var user: User = User(id: "", username: "", email: "", sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timeToWake: nil)
    
    private var fireDBHelper: FireDBHelper
    
    
    init() {
        self.fireDBHelper = FireDBHelper()
    }
    
    func fetchUser() async {
        
        await fireDBHelper.fetchUser()
        
        DispatchQueue.main.async {
            self.user = self.fireDBHelper.user!
            self.preferences = self.user.preferences
        }
        
        print(#function, "user: \(String(describing: self.user))")
    }
    
    func updateUserPreferences() async {
        await fireDBHelper.updateUserPreferences(preferences: self.preferences)
    }
    

}
