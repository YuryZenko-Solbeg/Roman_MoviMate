//
//  NetworkManager.swift
//  MoviMate
//
//  Created by Roman Alikevich on 9.08.21.
//

import UIKit

protocol NetworkManager {
    var urlComponents: URLComponents { get set }
//    func addItem(param: String, value: String) -> NetworkManager
//    func build() -> URL
    
    func getListOfGenre(completionHandler: @escaping (Result<GenreList, Error>) -> Void)
    func getListOfMovie(id: Int, completionHandler: @escaping (Result<MovieList, Error>) -> Void)
    func getMovieById(id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}

//extension NetworkManager {
//
//    mutating func addItem(param: String, value: String) -> NetworkManager {
//        urlComponents.queryItems?.append(URLQueryItem(name: param, value: value))
//        return self
//    }
//
//    func build() -> URL {
//        guard let url = urlComponents.url else {
//
//            //put down default request
//            return URL(string: "")!
//        }
//
//        return url
//    }
//}

class NetworkManagerImpl: NetworkManager {
  
    var urlComponents: URLComponents
    var fetcher: NetworkFetcher!
    
    init(fetcher: NetworkFetcher) {
        urlComponents = URLComponents(string: "")!
        self.fetcher = fetcher
    }
    
    func getListOfGenre(completionHandler: @escaping (Result<GenreList, Error>) -> Void) {
        urlComponents = URLComponents(string: NetworkUrl.getListOfGenre.rawValue)!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: "9dcb2fc7f9c7799a5d892a673fa4d40c"),
                                    URLQueryItem(name: "language", value: "en")]
        fetcher.send(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    func getListOfMovie(id: Int, completionHandler: @escaping (Result<MovieList, Error>) -> Void) {
        urlComponents = URLComponents(string: "\(NetworkUrl.getListOfGenre.rawValue)/\(String(id))")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: "9dcb2fc7f9c7799a5d892a673fa4d40c"),
                                    URLQueryItem(name: "language", value: "en")]
        fetcher.send(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    func getMovieById(id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        urlComponents = URLComponents(string: "\(NetworkUrl.getMovieDescriptionByMovieId.rawValue)/\(String(id))")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: "9dcb2fc7f9c7799a5d892a673fa4d40c"),
                                    URLQueryItem(name: "language", value: "en")]
        fetcher.send(url: urlComponents.url!, completionHandler: completionHandler)
    }
}
