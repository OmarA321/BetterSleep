//
//  ManualAlarmViewModel.swift
//  BetterSleep
//
//  Created by Elias Alissandratos
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ManualAlarmViewModel: ObservableObject {
    
    @Published var isDynamicAlarmSelected = true
    @Published var isManualAlarmSelected = false
    
    @Published var isSetTimeToWakeUp = false
    @Published var isSetTimeToSleep = false
    
    @Published var selectedTimeToWake: Date = Date()
    @Published var selectedTimeToSleep: Date = Date()
    @Published var alarmSet: Bool = false
    
    @Published var isCalculatingOptimalSleepTimes = false
    @Published var isCalculatingOptimalWakeTimes = false
    
    @Published var settingAlarm = false
    
    @Published var showLeftWakeTimes = false
    @Published var showRightWakeTimes = false
    @Published var showLeftSleepTimes = false
    @Published var showRightSleepTimes = false
    
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    @Published var suggestedTimes: [Double: Date] = [:]
    @Published var showingPopup = false
    
    
    var user: User = User(id: "", username: "", email: "", sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timeToWake: nil)
    
    private var fireDBHelper: FireDBHelper
    
    private var increments: [TimeInterval] = [1.5 * 3600, 3 * 3600, 4.5 * 3600, 6 * 3600, 7.5 * 3600, 9 * 3600, 10.5 * 3600, 12 * 3600, 13.5 * 3600]
    
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
    
    func deleteUserAlarm() async {
        self.user.timeToSleep = nil
        self.user.timeToWake = nil
        await fireDBHelper.updateUserAlarm(timeToSleep: nil, timeToWake: nil)
    }
    
    func calculateOptimalSleepTimes() {
        let calendar = Calendar.current
        var suggestedSleepTimes: [Double: Date] = [:]
        
        for increment in self.increments {
            let suggestedTime = calendar.date(byAdding: .second, value: Int(-increment), to: self.selectedTimeToWake)!
            suggestedSleepTimes[increment/3600] = suggestedTime
        }
        
        self.suggestedTimes = suggestedSleepTimes
    }
    
    func calculateOptimalWakeTimes() {
        let calendar = Calendar.current
        var suggestedWakeTimes: [Double: Date] = [:]
        
        for increment in self.increments {
            let suggestedTime = calendar.date(byAdding: .second, value: Int(increment), to: self.selectedTimeToSleep)!
            suggestedWakeTimes[increment/3600] = suggestedTime
        }
        
        self.suggestedTimes = suggestedWakeTimes
    }
}
    
