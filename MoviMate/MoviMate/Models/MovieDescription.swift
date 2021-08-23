//
//  MovieDescription.swift
//  MoviMate
//
//  Created by Roman Alikevich on 10.08.21.
//

import UIKit

struct MovieDescription: Codable {
    
    var id: Int
    var releaseDate: Date
    var budget: Int
    var tagline: String
    var genreType:[Genre]
    var icon: String
    var title: String
    var overview: String
    var rating: Float
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let buff = try container.decode(String.self, forKey: .releaseDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: buff)
        
        releaseDate = date!
        budget = try container.decode(Int.self, forKey: .budget)
        tagline = try container.decode(String.self, forKey: .tagline)
        genreType = try container.decode([Genre].self, forKey: .genreType)
        icon = try container.decode(String.self, forKey: .icon)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        rating = try container.decode(Float.self, forKey: .rating)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, budget, tagline, releaseDate = "release_date", genreType = "genres", icon = "poster_path", title, overview, rating = "vote_average"
    }
}

struct Genre: Codable {
    
    var id: Int
    var name: String
}
