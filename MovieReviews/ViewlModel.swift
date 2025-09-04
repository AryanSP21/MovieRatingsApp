//
//  ViewModel.swift
//  MovieRatings
//
//

import Foundation

class ViewModel: ObservableObject {
    @Published var movies: [Movie] = Movie.allMovies
    @Published var currentMovieIndex: Int = 0
    @Published var currentMovie: Movie = Movie.allMovies[0]
    @Published var showRatingsView: Bool = false
    
    func rateMovie(rating: Int) {
        movies[currentMovieIndex].rating = rating
        currentMovie = movies[currentMovieIndex]
    }
    
    func getNextMovie() {
        currentMovieIndex = (currentMovieIndex + 1) % movies.count
        currentMovie = movies[currentMovieIndex]
    }
}

