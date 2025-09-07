import SwiftUICore
import SwiftUI

struct RatingsListView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var authVM: AuthViewModel
    var onSelectMovie: ((Movie) -> Void)?
    
    var body: some View {
        VStack {
            Text("My Ratings")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.movies) { movie in
                        // Find the current user's review for this movie
                        let userReview = movie.reviews.first { $0.userId == authVM.user?.uid }
                        
                        Button(action: {
                            onSelectMovie?(movie)   // if user clicks a movie, redirect them to the movie page
                        }) {
                            HStack {
                                // Movie Poster
                                Image(movie.posterImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    // Movie Name
                                    Text(movie.title)
                                        .font(.headline)
                                    
                                    // Stars (only if reviewed, otherwise empty stars or "Not reviewed yet")
                                    if let review = userReview {
                                        HStack {
                                            ForEach(1...5, id: \.self) { star in
                                                Image(systemName: star <= review.rating ? "star.fill" : "star")
                                                    .foregroundColor(.yellow)
                                            }
                                        }
                                        
                                        // Review text
                                        Text(review.text.isEmpty ? "No review left" : review.text)
                                            .font(.subheadline)
                                            .foregroundColor(.white.opacity(0.9))
                                            .padding(.top, 4)
                                    } else {
                                        Text("Not reviewed yet")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .padding(.top, 4)
                                    }
                                }
                                .padding()
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue.cornerRadius(10))
                            .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

