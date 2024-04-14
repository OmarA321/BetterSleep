//
//  SignUpViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel : ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password =  ""
    @Published var errorMessage = ""
    @Published var isShowingError = false
    
    init() {
        
    }
    
    func register() {
        
        guard validate() else {
            isShowingError = true
            print(#function, "yikes?")
            return
        }
    
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            guard let userId = result?.user.uid else {
                print(#function, error)
                return
            }
            self.addUserToFirestore(id: userId)
            print(#function, "User \(self.username) \(userId) added!")
        }
        
    }
    
    private func addUserToFirestore(id: String) {
       
        var newUser = User(id: id, username: username, email: email, sleepHistory: [], recommendations: [], preferences: UserPreferences(antiBlueLightMode: false, disableStars: false), timeToSleep: nil, timeToWake: nil)
        
        let db = Firestore.firestore()
        
        do {
          try db.collection("users").document(id).setData(from: newUser)
        } catch let error {
          print("Error writing user to Firestore: \(error)")
        }
    }
    
    private func validate() -> Bool {
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        guard password.count > 7 else {
            errorMessage = "Password must be at least 8 characters!"
            return false
        }
        
        return true
        
    }
    
}
