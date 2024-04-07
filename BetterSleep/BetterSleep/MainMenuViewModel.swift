//
//  MainMenuViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class MainMenuViewModel: ObservableObject {
    
    @Published var user: User? = nil
    
    init() {
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument { (document, error) in
                
                if let document = document {
                    let data = document.data()
                    self.user = User(id: data?["id"] as? String ?? "", username: data?["username"] as? String ?? "", email: data?["email"] as? String ?? "", sleepHistory: data?["sleepHistory"] as? [SleepRecord] ?? [], recommendations: data?["recommendations"] as? [Recommendation] ?? [], preferences: data?["preferences"] as? UserPreferences ?? UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: data?["timeToSleep"] as? Date, timetoWake: data?["timeToWake"] as? Date)
                    
                }
            }
    } // fetchUser()
    
    
}

