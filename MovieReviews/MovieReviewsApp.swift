//
//  MovieReviewsApp.swift
//  MovieReviews
//
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct MovieReviewsApp: App {
    @StateObject var authVM = AuthViewModel()
    @StateObject var movieVM = ViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if let _ = authVM.user {
                MovieRatingsView(viewModel: movieVM, authVM: authVM)
            } else {
                LoginView(authVM: authVM)
            }
        }
    }

}
