//
//  ContentView.swift
//  MovieReviews
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var authVM = AuthViewModel()
    
    var body: some View {
        if authVM.user != nil {
            MovieRatingsView(viewModel: viewModel, authVM: authVM)
        } else {
            LoginView(authVM: authVM)
        }
    }
}

#Preview {
    ContentView()
}

