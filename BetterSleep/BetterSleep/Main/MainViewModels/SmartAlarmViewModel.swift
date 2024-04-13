//
//  SmartAlarmViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-07.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import AVFoundation

class SmartAlarmViewModel: ObservableObject {
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    
    @Published var isDynamicAlarmSelected = true
    @Published var isManualAlarmSelected = false
    
    @Published var isSetTimeToWakeUp = false
    @Published var isSetTimeToSleep = false
    
    @Published var selectedTimeToWake: Date = Date()
    @Published var selectedTimeToSleep: Date = Date()
    @Published var alarmSet: Bool = false
    
    @Published var isCalculatingOptimalSleepTimes = false
    @Published var suggestedSleepTimes: [Date] = []
    
    @Published var isCalculatingOptimalWakeTimes = false
    @Published var suggestedWakeTimes: [Date] = []
    
    @Published var showingPopup = false
    @Published var settingAlarm = false
    
    @Published var showLeftWakeTimes = false
    @Published var showRightWakeTimes = false
    @Published var showLeftSleepTimes = false
    @Published var showRightSleepTimes = false
    @Published var player: AVAudioPlayer?
    
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
            if self.user.timeToSleep != nil || self.user.timeToWake != nil {
                self.alarmSet = true
                self.selectedTimeToSleep = self.user.timeToSleep ?? Date()
                self.selectedTimeToWake = self.user.timeToWake ?? Date()
            }
            
        }
        
        print(#function, "user: \(String(describing: self.user))")
    }
    
    func updateUserAlarm() async {
        
        self.user.timeToSleep = self.selectedTimeToSleep
        self.user.timeToWake = self.selectedTimeToWake
        
        await fireDBHelper.updateUserAlarm(timeToSleep: self.selectedTimeToSleep, timeToWake: self.selectedTimeToWake)
    }
    
    
    

    func playAlarmSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func calculateOptimalSleepTimes() {
        
    }
    
    
    
        

}
    
