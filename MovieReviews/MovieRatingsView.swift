import SwiftUICore
import SwiftUI
struct MovieRatingsView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var authVM: AuthViewModel
    @State private var selectedRating: Int = 0
    @State private var reviewText: String = ""
    @State private var showingReviews = false
    @State private var showNoReviewsAlert = false
    private let firestoreManager = FirestoreManager()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.showRatingsView = true
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        .padding()
                    }
                    
                    Image(viewModel.currentMovie.posterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .padding()
                    
                    HStack {
                        Text(viewModel.currentMovie.title)
                            .font(.title)
                            .bold()
                                        
                        Text(String(viewModel.currentMovie.year))
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Text(viewModel.currentMovie.description)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack {
                        ForEach(1...5, id: \ .self) { star in
                            Image(systemName: star <= selectedRating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    selectedRating = star
                                }
                        }
                    }
                    .padding()
                    
                    TextField("Write a review...", text: $reviewText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    // Buttons (Submit Review, Next Movie, View Reviews)
                    VStack(spacing: 15) {
                
                        // Submit Review
                        Button("Submit Review") {
                            guard let user = authVM.user else { return }
                                
                                let userReview = Review(
                                    id: user.uid,
                                    username: user.email,
                                    userId: user.uid,
                                    rating: selectedRating,
                                    text: reviewText
                                )
                                
                                firestoreManager.addOrUpdateReview(
                                    movieId: viewModel.currentMovie.id,
                                    review: userReview
                                )
                                
                                // update local cache so UI refreshes
                            viewModel.addReview(to: viewModel.currentMovie, review: reviewText, rating: selectedRating, userId: user.uid, username: user.email ?? "Anonymous")

                        }
                        .buttonStyle(GradientButtonStyle(backgroundColor: .green))
                        
                        // View Reviews (always visible)
                        Button("View Reviews") {
                            if viewModel.currentMovie.reviews.isEmpty {
                                showNoReviewsAlert = true
                            } else {
                                showingReviews = true
                            }
                        }
                        .buttonStyle(GradientButtonStyle(backgroundColor: .blue))
                        
                        // Next Movie
                        Button("Next Movie") {
                            viewModel.rateMovie(rating: selectedRating)
                            viewModel.getNextMovie()
                            selectedRating = viewModel.currentMovie.rating
                        }
                        .buttonStyle(GradientButtonStyle(backgroundColor: .orange))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                authVM.signOut()
                            }) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            .padding()
                        }
                        
                    }
                    .padding(.top)
                }
            }
            .padding()
        }
        .onChange(of: viewModel.currentMovie.id) {
            if let existingReview = viewModel.currentMovie.reviews.first {
                reviewText = existingReview.text          // ← use struct field
                selectedRating = existingReview.rating     // ← use struct field
            } else {
                reviewText = ""
                selectedRating = 0
            }
        }
        .sheet(isPresented: $showingReviews) {
            // ReviewsSheet(reviews: viewModel.currentMovie.reviews)
            ReviewsSheet(movieId: viewModel.currentMovie.id)
        }
        .sheet(isPresented: $viewModel.showRatingsView) {
            RatingsListView(viewModel: viewModel, authVM: authVM) { selectedMovie in
                viewModel.currentMovie = selectedMovie
                viewModel.showRatingsView = false
            }
        }
        .alert("No Reviews", isPresented: $showNoReviewsAlert) {
                    Button("OK", role: .cancel) {}
        } message: {
            Text("There are currently no reviews")
        }
//        .onAppear {
//            loadUserReview()
//        }
//        .onChange(of: viewModel.currentMovie.id) {
//            loadUserReview()
//        }
        .onAppear {
            loadUserReview()
            viewModel.startListeningForReviews(movieId: viewModel.currentMovie.id)
        }
        .onChange(of: viewModel.currentMovie.id) { newId in
            loadUserReview()
            viewModel.startListeningForReviews(movieId: newId)
        }

    }
    
    private func startListeningForReviews() {
        firestoreManager.listenForReviews(movieId: viewModel.currentMovie.id) { reviews in
            if let index = viewModel.movies.firstIndex(where: { $0.id == viewModel.currentMovie.id }) {
                viewModel.movies[index].reviews = reviews
                viewModel.currentMovie = viewModel.movies[index] // refresh UI
            }
        }
    }
    
    private func loadUserReview() {
        guard let userId = authVM.user?.uid else { return }
        firestoreManager.fetchUserReview(movieId: viewModel.currentMovie.id, userId: userId) { review in
            if let review = review {
                self.reviewText = review.text
                self.selectedRating = review.rating
            } else {
                self.reviewText = ""
                self.selectedRating = 0
            }
        }
    }

}

struct GradientButtonStyle: ButtonStyle {
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor.opacity(configuration.isPressed ? 0.7 : 1.0))
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}
