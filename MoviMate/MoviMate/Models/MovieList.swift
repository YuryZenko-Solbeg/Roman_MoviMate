//
//  Movie.swift
//  MoviMate
//
//  Created by Roman Alikevich on 10.08.21.
//

import UIKit

struct MovieList: Codable {
    var id: Int
    var items: [Movie]
}

struct Movie: Codable {
    var id: Int
    var genreType:[Int]
    var language: String
    var title: String
    var overview: String
    var rating: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        genreType = try container.decode([Int].self, forKey: .genreType)
        language = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .id)
        overview = try container.decode(String.self, forKey: .overview)
        rating = try container.decode(Int.self, forKey: .rating)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, genreType = "genre_ids", language, title, overview, rating = "vote_average"
    }
}
