import SwiftUICore
import SwiftUI
struct MovieRatingsView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedRating: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
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
                
                Button("Next Movie") {
                    viewModel.rateMovie(rating: selectedRating)
                    viewModel.getNextMovie()
                    selectedRating = viewModel.currentMovie.rating
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
//                Button("View My Ratings") {
//                    viewModel.showRatingsView = true
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showRatingsView) {
            RatingsListView(viewModel: viewModel)
        }
    }
}
