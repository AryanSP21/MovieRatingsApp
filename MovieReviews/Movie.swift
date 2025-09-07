//
//  Movie.swift
//  MovieReviews
//

import Foundation

struct Review: Identifiable, Codable {
    var id: String = UUID().uuidString
    var username: String = "John_Doe"
    var userId: String = "User123"
    var rating: Int
    var text: String
}

struct Movie: Identifiable, Codable {
    // var id: String = UUID().uuidString
    let id: String
    let title: String
    let year: Int
    let description: String
    let posterImage: String
    var rating: Int
    var reviews: [Review] = []
    
    static let allMovies: [Movie] = [
        Movie(id: "Back to the Future", title: "Back To The Future", year: 1985, description: "Eighties teenager Marty McFly is accidentally sent back in time to 1955, inadvertently disrupting his parents' first meeting...", posterImage: "back_to_the_future", rating: 0),
        Movie(id: "Barbie", title: "Barbie", year: 2023, description: "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land...", posterImage: "barbie", rating: 0),
        Movie(id: "Spider-man", title: "Spider-Man: Across the Spider-Verse", year: 2023, description: "Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence...", posterImage: "spiderman", rating: 4),
        Movie(id: "Batman", title: "The Dark Knight", year: 2008, description: "Batman, District Attorney Harvey Dent, and Lieutenant Jim Gordon form an alliance to dismantle organized crime in Gotham City", posterImage: "batman", rating: 0),
        Movie(id: "Godfather", title: "The Godfather", year: 1972, description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son", posterImage: "godfather", rating: 0),
        Movie(id: "Parasite", title: "Parasite", year: 2019, description: "The other members of the poor Kim family see an opportunity when their son starts working for the rich Park family.", posterImage: "parasite", rating: 0),
        Movie(id: "Interstellar", title: "Interstellar", year: 2014, description: "Earth's last chance to find a habitable planet before a lack of resources causes the human race to go extinct", posterImage: "interstellar", rating: 0),
        Movie(id: "Transformers", title: "Transformers", year: 2007, description: "A science fiction action film about the conflict between two alien robot races, the Autobots and Decepticons, spilling onto Earth", posterImage: "transformers", rating: 0),
    ]
}
