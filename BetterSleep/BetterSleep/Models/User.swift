//
//  User.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-03-24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    var username: String
    var sleepHistory: [SleepRecord]
}
