//
//  Recommendation.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation

struct Recommendation: Codable {
    var description: String
    
    enum UserKeys: String, CodingKey {
        case description
        
    }
}
