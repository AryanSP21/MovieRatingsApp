//
//  LoginView.swift
//  MovieReviews
//
//  Created by Aryan Patel on 9/4/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Movie Reviews")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 44)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 44)
                .padding(.horizontal)
            
            if !authVM.errorMessage.isEmpty {
                Text(authVM.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            VStack(spacing: 15) {
                Button("Log In") {
                    authVM.login(email: email, password: password)
                }
                .buttonStyle(GradientButtonStyle(backgroundColor: .blue))
                
                Button("Sign Up") {
                    authVM.signUp(email: email, password: password)
                }
                .buttonStyle(GradientButtonStyle(backgroundColor: .green))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 50)
    }
}
