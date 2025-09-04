//
//  Movie.swift
//  MovieReviews
//

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let year: Int
    let description: String
    let posterImage: String
    var rating: Int
    
    static let allMovies: [Movie] = [
        Movie(title: "Back To The Future", year: 1985, description: "Eighties teenager Marty McFly is accidentally sent back in time to 1955, inadvertently disrupting his parents' first meeting...", posterImage: "back_to_the_future", rating: 0),
        Movie(title: "Barbie", year: 2023, description: "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land...", posterImage: "barbie", rating: 0),
        Movie(title: "Spider-Man: Across the Spider-Verse", year: 2023, description: "Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence...", posterImage: "spiderman", rating: 4),
        Movie(title: "The Dark Knight", year: 2010, description: "I am Batman", posterImage: "batman", rating: 0),
        Movie(title: "The Godfather", year: 1985, description: "akjhahdkahdaJdjajda", posterImage: "godfather", rating: 0),
        Movie(title: "Parasite", year: 2018, description: "adbhjdjahdgjagjgdjajhdgjdgjagagdjhgagjh", posterImage: "parasite", rating: 0),
        Movie(title: "Interstellar", year: 2012, description: "Man going to space", posterImage: "interstellar", rating: 0),
        Movie(title: "Transformers", year: 1985, description: "Autobots Roll Out...", posterImage: "transformers", rating: 0),
    ]
}
