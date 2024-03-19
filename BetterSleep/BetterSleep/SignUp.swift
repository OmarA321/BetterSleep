// SignUp.swift
// BetterSleep
//
// Created by Omar Al dulaimi on 2024-03-18.

import SwiftUI

struct SignUp: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var shouldNavigateToContentView = false // State for navigation control


    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.mint, Color.indigo]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                Text("Join BetterSleep")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
                
                Group {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.yellow.opacity(0.3))
                        
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }

                Button(action: {
                    self.shouldNavigateToContentView = true

                    // Handle sign-up action
                    
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.mint)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.indigo)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                NavigationLink(destination: ContentView()
                    .preferredColorScheme(.dark)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true), // Additional attempt to remove space
                    isActive: $shouldNavigateToContentView) {
                    EmptyView()
                }
                
                Spacer()
                
                // Redirect to login with updated colors and functionality
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(Color.yellow)
                    Button("Login") {
                        // This will dismiss the SignUp view to go back to the Login view
                        presentationMode.wrappedValue.dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
                }
            }
        }
    }
}

// Preview
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
