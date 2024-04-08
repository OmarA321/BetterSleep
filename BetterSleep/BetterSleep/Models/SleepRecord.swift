//
//  SleepRecord.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-03-24.
//

import Foundation

struct SleepRecord: Codable, Hashable {
    var date: Date
    var hoursSlept: Double
    var qualityRating: String
    
    enum UserKeys: String, CodingKey {
        case date
        case hoursSlept
        case qualityRating
        
    }
}
