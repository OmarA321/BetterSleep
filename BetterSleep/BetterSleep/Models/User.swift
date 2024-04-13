//
//  User.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-03-24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var username: String
    var email: String
    var sleepHistory: [SleepRecord]
    var recommendations: [Recommendation]
    var preferences: UserPreferences
    var timeToSleep: Date?
    var timeToWake: Date?
    
    enum UserKeys: String, CodingKey {
        case username
        case email
        case sleepHistory
        case recommendations
        case preferences
        case timeToSleep
        case timeToWake
        
    }

}
