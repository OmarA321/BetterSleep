//
//  LoginViewModel.swift
//  BetterSleep
//
//  Created by alyssa verasamy on 2024-04-06.
//

import Foundation
import FirebaseAuth

class LoginViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    //TODO: move all database functions to FireDBHelper
    func login() {
        
        guard validate() else {
            
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
        
        //TODO: implement error if login fails
        
    }
    
    //TODO: implement validation in view
    private func validate() -> Bool {
        
        errorMessage = ""   // reset error message
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please fill in all fields"
            
            return false
        }
        
        // email@google.com
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        guard password.count > 7 else {
            errorMessage = "Password must be at least 8 characters"
            return false
        }
        
        return true
        
    }
    
}
