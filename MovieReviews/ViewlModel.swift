//
//  ViewModel.swift
//  MovieRatings
//
//

import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    @Published var movies: [Movie] = Movie.allMovies
    @Published var currentMovieIndex: Int = 0
    @Published var currentMovie: Movie = Movie.allMovies[0]
    @Published var showRatingsView: Bool = false
    
    private let firestoreManager = FirestoreManager()
    private var reviewListener: ListenerRegistration?
    
    func rateMovie(rating: Int) {
        movies[currentMovieIndex].rating = rating
        currentMovie = movies[currentMovieIndex]
    }
    
    func addReview(to movie: Movie, review: String, rating: Int, userId: String, username: String) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            let newReview = Review(id: userId, username: username, userId: userId, rating: rating, text: review)

            movies[index].reviews.removeAll { $0.userId == userId }
            movies[index].reviews.append(newReview)
            movies[index].rating = rating
            currentMovie = movies[index]
        }
    }

    func getNextMovie() {
        currentMovieIndex = (currentMovieIndex + 1) % movies.count
        currentMovie = movies[currentMovieIndex]
    }
    
    // Start listening to Firestore for the current movie
    func startListeningForReviews(movieId: String) {
        // Stop any old listener
        reviewListener?.remove()
        
        reviewListener = firestoreManager.listenForReviews(movieId: movieId) { [weak self] reviews in
            guard let self = self else { return }
            
            if let index = self.movies.firstIndex(where: { $0.id == movieId }) {
                self.movies[index].reviews = reviews
                self.currentMovie = self.movies[index]  // refresh UI
            }
        }
    }
    
    deinit {
        reviewListener?.remove()
    }
}
