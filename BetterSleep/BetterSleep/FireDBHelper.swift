//
//  FireDBHelper.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireDBHelper: ObservableObject {
    
    @Published var user: User?
    
    public static var shared: FireDBHelper?
    private var db: Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
//    static func getInstance() -> FireDBHelper {
//        if self.shared == nil {
//            self.shared = FireDBHelper(database: Firestore.firestore())
//        }
//        return self.shared!
//    }
    
    
    
    func fetchUser() async {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        print(#function, "attempting to log in user id \(userId)")
        
        let docRef = self.db.collection("users").document(userId)
        
        do {
            self.user = try await docRef.getDocument(as: User.self)
            print("user: \(String(describing: self.user))")
        } catch {
            print("error decoding user \(error)")
        }
    }
    
    func updateUserPreferences(preferences: UserPreferences) async {
        
        let docRef = self.db.collection("users").document(self.user!.id!)
        
        do {

          try await docRef.updateData([
            "preferences.antiBlueLightMode": preferences.antiBlueLightMode,
            "preferences.disableStars": preferences.disableStars,
          ])
          print("Document successfully updated")
        } catch {
          print("Error updating document: \(error)")
        }
        
    }
    
    func addUserSleepRecord(sleepRecord: SleepRecord) async {
        
        let docRef = db.collection("users").document(self.user!.id!)
        
        self.user!.sleepHistory.append(sleepRecord)
        
        do {
            try docRef.setData(from: self.user)
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
        
    }
    
    func updateUserAlarm(timeToSleep: Date, timeToWake: Date) async {
        
        let docRef = self.db.collection("users").document(self.user!.id!)
        
        do {

          try await docRef.updateData([
            "timeToSleep": timeToSleep,
            "timeToWake": timeToWake,
          ])
          print("Document successfully updated")
        } catch {
          print("Error updating document: \(error)")
        }
        
    }
    
}
