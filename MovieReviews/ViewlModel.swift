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
    
    func addReview(to movie: Movie, review: String, rating: Int) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            let newReview = Review(rating: rating, text: review)
            
            if movies[index].reviews.isEmpty {
                movies[index].reviews = [newReview]
            } else {
                movies[index].reviews[0] = newReview // replace/edit existing review
            }
            
            movies[index].rating = rating
            currentMovie = movies[index]
        }
    }

    
    func getNextMovie() {
        currentMovieIndex = (currentMovieIndex + 1) % movies.count
        currentMovie = movies[currentMovieIndex]
    }
}

