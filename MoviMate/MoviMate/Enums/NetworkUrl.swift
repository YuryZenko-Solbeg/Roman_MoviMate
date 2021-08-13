//
//  NetworkUrl.swift
//  MoviMate
//
//  Created by Roman Alikevich on 10.08.21.
//

import UIKit

enum NetworkUrl: String {
    case getListOfGenre = "https://api.themoviedb.org/3/genre/movie/list"
    case getListOfMovieByGenreId = "https://api.themoviedb.org/3/list"
    case getMovieDescriptionByMovieId = "https://api.themoviedb.org/3/movie/"
    case getMoviePostImage = "https://image.tmdb.org/t/p/"
}
