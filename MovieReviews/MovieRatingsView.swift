import SwiftUICore
import SwiftUI
struct MovieRatingsView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedRating: Int = 0
    @State private var reviewText: String = ""
    @State private var showingReviews = false
    @State private var showNoReviewsAlert = false
    
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
                               viewModel.addReview(to: viewModel.currentMovie,
                                                   review: reviewText,  // can be empty, incase user wants to leave a rating (out of 5), but not a text review
                                                   rating: selectedRating)
                               reviewText = ""  // clear text field
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
            ReviewsSheet(reviews: viewModel.currentMovie.reviews)
        }
        .sheet(isPresented: $viewModel.showRatingsView) {
            RatingsListView(viewModel: viewModel) { selectedMovie in
                viewModel.currentMovie = selectedMovie
                viewModel.showRatingsView = false
            }
        }
        .alert("No Reviews", isPresented: $showNoReviewsAlert) {
                    Button("OK", role: .cancel) {}
        } message: {
            Text("There are currently no reviews")
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
