//
//  ReviewsSheet.swift
//  MovieReviews
//
//  Created by Aryan Patel on 9/4/25.
//

import SwiftUI
import FirebaseFirestore

struct ReviewsSheet: View {
    let movieId: String
    @State private var reviews: [Review] = []
    private let firestoreManager = FirestoreManager()
    @State private var listener: ListenerRegistration?

    var body: some View {
        NavigationView {
            Group {
                if reviews.isEmpty {
                    Text("No reviews yet")
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                } else {
                    List(reviews) { review in
                        VStack(alignment: .leading, spacing: 6) {
                            // Stars
                            HStack(spacing: 2) {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= review.rating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                            }
                            
                            // Review text
                            Text(review.text.isEmpty ? "No text provided" : review.text)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            
                            // Username
                            Text("- \(review.username)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("All Reviews")
            .onAppear {
                listener = firestoreManager.listenForReviews(movieId: movieId) { fetched in
                    reviews = fetched
                }
            }
            .onDisappear {
                listener?.remove()
            }
        }
    }
}


