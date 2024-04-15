//
//  SmartAlarmViewModel.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import AVFoundation
import HealthKit

class SmartAlarmViewModel: ObservableObject {
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)

    @Published var selectedTimeToWake: Date = Date()
    @Published var selectedTimeToSleep: Date = Date()
    @Published var alarmSet: Bool = false
    @Published var suggestedSleepTimes: [Date] = []
    
    @Published var suggestedWakeTimes: [Date] = []
    
    @Published var showingPopup = false
    @Published var settingAlarm = false
    
    @Published var player: AVAudioPlayer?
    
    @Published var dynamicAlarm: Bool = false
    
    @Published var userAlarmTime: Date?
    
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
                self.userAlarmTime = self.user.timeToWake
            }
            
        }
        
        print(#function, "user: \(String(describing: self.user))")
    }
    
    func updateUserAlarm() async {
        
        self.user.timeToSleep = self.selectedTimeToSleep
        self.user.timeToWake = self.selectedTimeToWake
        self.userAlarmTime = self.selectedTimeToWake
        
        await fireDBHelper.updateUserAlarm(timeToSleep: self.selectedTimeToSleep, timeToWake: self.selectedTimeToWake)
    }
    
    func deleteUserAlarm() async {
        self.user.timeToSleep = nil
        self.user.timeToWake = nil
        self.userAlarmTime = nil
        await fireDBHelper.updateUserAlarm(timeToSleep: nil, timeToWake: nil)
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
    
    let healthStore = HKHealthStore()

    func requestSleepAuthorization() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { success, error in
            if let error = error {
                print("Error requesting sleep authorization: \(error.localizedDescription)")
            } else {
                if success {
                    print("Sleep authorization granted")
                    self.fetchSleepData()
                } else {
                    print("Sleep authorization denied")
                }
            }
        }
    }

    func fetchSleepData() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { query, results, error in
            guard let samples = results as? [HKCategorySample], let lastSleepSample = samples.first else {
                print("Error fetching sleep data: \(error?.localizedDescription ?? "No data available")")
                return
            }
            let sleepStartDate = lastSleepSample.startDate
            print("User fell asleep at: \(sleepStartDate)")
            
            self.selectedTimeToSleep = sleepStartDate
            
            var newWakeUpTime = sleepStartDate
            while newWakeUpTime <= self.selectedTimeToWake {
                newWakeUpTime = Calendar.current.date(byAdding: .minute, value: 90, to: newWakeUpTime) ?? sleepStartDate
            }
            
            if newWakeUpTime > sleepStartDate {
                newWakeUpTime = Calendar.current.date(byAdding: .minute, value: -90, to: newWakeUpTime) ?? sleepStartDate
            }
            
            self.selectedTimeToWake = newWakeUpTime
            
        }
        healthStore.execute(query)
    }
}
    
