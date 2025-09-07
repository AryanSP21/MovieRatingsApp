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
    @State private var isPasswordHidden = true
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Movie Reviews")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.all, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                    )
                    .frame(height: 44)
                    .padding(.horizontal)
                
                // Password Field with Hide/Show
                ZStack(alignment: .trailing) {
                    Group {
                        if isPasswordHidden {
                            SecureField("Password", text: $password)
                                .disableAutocorrection(true)
                        } else {
                            TextField("Password", text: $password)
                                .disableAutocorrection(true)
                        }
                    }
                    .padding(.all, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                    )

                    Button(action: {
                        isPasswordHidden.toggle()
                    }) {
                        Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 12) // inside the box
                }
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
                    .buttonStyle(GradientButtonStyle(backgroundColor: .pink))
                    
                    Button("Sign Up") {
                        authVM.signUp(email: email, password: password)
                    }
                    .buttonStyle(GradientButtonStyle(backgroundColor: .blue))
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
        }
    }
}
