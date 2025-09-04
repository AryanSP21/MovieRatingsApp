import SwiftUICore
import SwiftUI
struct RatingsListView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("My Ratings")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.movies) { movie in
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
                                // Movie Ratings the user left
                                HStack {
                                    ForEach(1...5, id: \.self) { star in
                                        Image(systemName: star <= movie.rating ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                
                                // Review text (if any)
                                if let review = movie.reviews.first {
                                    Text(review.text)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                        .padding(.top, 4)
                                } else {
                                    Text("No review left")
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
                .padding()
            }
        }
    }
}
