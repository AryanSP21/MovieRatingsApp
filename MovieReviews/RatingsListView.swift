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
                            Image(movie.posterImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 120)
                                .cornerRadius(10)
                                
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.headline)
                                Text("\(movie.rating)/5")
                                    .bold()
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
