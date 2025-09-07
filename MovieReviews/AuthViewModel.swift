//
//  AuthViewModel.swift
//  MovieReviews
//
//  Created by Aryan Patel on 9/4/25.
//
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var errorMessage: String = ""
    
    init() {
        if let firebaseUser = Auth.auth().currentUser {
            self.user = User(uid: firebaseUser.uid, email: firebaseUser.email ?? "")
        }
    }
    
    func login(email: String, password: String) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: trimmedEmail, password: trimmedPassword) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let firebaseUser = result?.user {
                    self.user = User(uid: firebaseUser.uid, email: firebaseUser.email ?? "")
                    self.errorMessage = ""
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedPassword.count >= 6 else {
            self.errorMessage = "Password must be at least 6 characters long."
            return
        }
        
        Auth.auth().createUser(withEmail: trimmedEmail, password: trimmedPassword) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let firebaseUser = result?.user {
                    self.user = User(uid: firebaseUser.uid, email: firebaseUser.email ?? "")
                    self.errorMessage = ""
                }
            }
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                self.user = nil
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
}

struct User {
    let uid: String
    let email: String
}
