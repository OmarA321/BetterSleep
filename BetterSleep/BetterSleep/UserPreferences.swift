//
//  Preferences.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation

struct UserPreferences: Codable {
    var antiBlueLightMode: Bool
    var disableStars: Bool
    
    enum UserPreferencesKeys: String, CodingKey {
        case antiBlueLightMode
        case disableStars
        
    }
}
