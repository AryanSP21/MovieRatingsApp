//
//  ReviewsSheet.swift
//  MovieReviews
//
//  Created by Aryan Patel on 9/4/25.
//

import SwiftUI

struct ReviewsSheet: View {
    let reviews: [Review]
    
    var body: some View {
        NavigationView {
            List(reviews) { review in
                VStack(alignment: .leading, spacing: 6) {
                    // Stars
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= review.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    // Review text
                    Text(review.text)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Reviews")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


