//
//  ContentView.swift
//  MovieReviews
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
        
        var body: some View {
            MovieRatingsView(viewModel: viewModel)
        }
}

#Preview {
    ContentView()
}
