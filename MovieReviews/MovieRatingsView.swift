import SwiftUICore
import SwiftUI
struct MovieRatingsView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedRating: Int = 0
    @State private var reviewText: String = ""
    @State private var showingReviews = false
    
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

                    Button("Submit Review") {
                        if !reviewText.isEmpty {
                            viewModel.addReview(to: viewModel.currentMovie, review: reviewText, rating: selectedRating)
                        }
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)


                    Button("Next Movie") {
                        viewModel.rateMovie(rating: selectedRating)
                        viewModel.getNextMovie()
                        selectedRating = viewModel.currentMovie.rating
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    if !viewModel.currentMovie.reviews.isEmpty {
                        Button("View Reviews") {
                            showingReviews = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
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
            RatingsListView(viewModel: viewModel)
        }
    }
}
