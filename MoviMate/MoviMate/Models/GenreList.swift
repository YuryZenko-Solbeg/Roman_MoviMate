//
//  Genre.swift
//  MoviMate
//
//  Created by Roman Alikevich on 10.08.21.
//

import UIKit

struct GenreList: Codable {
    
    var genres: [Genres]
}

struct Genres: Codable {
    
    var id: Int
    var name: String
    var url: GenreImageUrl?
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}


