//
//  SettingsViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-07.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class SettingsViewModel: ObservableObject {
    
    //TODO: add publisher to avoid warnings updating these variables in function
    @Published var preferences: UserPreferences = UserPreferences(antiBlueLightMode: false, disableStars: false)
    
    private var user: User = User(id: "", username: "", email: "", sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timetoWake: nil)
    
    init() {
    }
    
    //TODO: move all database functions to FireDBHelper
    func fetchUser() async {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        print(#function, "attempting to log in user id \(userId)")
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userId)
        
        do {
            self.user = try await docRef.getDocument(as: User.self)
            self.preferences = self.user.preferences
            print("user: \(self.user)")
        } catch {
            print("error decoding user \(error)")
        }
            
            
            
            
        }
        
        
    
    //TODO: move all database functions to FireDBHelper
    func updateUserPreferences() async {
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(self.user.id!)
        
        do {

          try await docRef.updateData([
            "preferences.antiBlueLightMode": self.preferences.antiBlueLightMode,
            "preferences.disableStars": self.preferences.disableStars,
          ])
          print("Document successfully updated")
        } catch {
          print("Error updating document: \(error)")
        }
        
    
    }
    

}
