//
//  MainMenuViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import AVFoundation

class MainMenuViewModel: ObservableObject {
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    
    @Published var stars: [Star] = []
    @Published var currentTime = Date()
    @Published var selectedTimeToSleep = Date()
    @Published var selectedTimeToWake = Date()
    @Published var userAlarmTime: Date?
    @Published var alarmSet = false
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
            self.alarmSet = self.user.timeToWake != nil
            self.userAlarmTime = self.user.timeToWake
        }
        
        print(#function, "user: \(String(describing: self.user))")
    }
    
    
    
    func checkAlarm() {
        let calendar = Calendar.current
        let currentTime = Date()
        
        if self.alarmSet {
            if calendar.isDate(currentTime, equalTo: self.userAlarmTime!, toGranularity: .minute) {
                playAlarmSound()
                self.alarmSet = false
                
            }
        }
        
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
    
    
    
    
    
        

}
    
    


