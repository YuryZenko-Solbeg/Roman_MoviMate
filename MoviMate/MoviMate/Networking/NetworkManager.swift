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
    func getMovieById(id: Int, completionHandler: @escaping (Result<MovieDescription, Error>) -> Void)
    func getMoviePoster(path: String) -> Data
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
    
    private static let apiKeyParam = "api_key"
    private static let languageParam = "language"
    private static let apiKey = "9dcb2fc7f9c7799a5d892a673fa4d40c"
    
    init(fetcher: NetworkFetcher) {
        urlComponents = URLComponents(string: "")!
        self.fetcher = fetcher
    }
    
    func getListOfGenre(completionHandler: @escaping (Result<GenreList, Error>) -> Void) {
        urlComponents = URLComponents(string: NetworkUrl.getListOfGenre.rawValue)!
        
        urlComponents.queryItems = [URLQueryItem(name: NetworkManagerImpl.apiKeyParam, value: NetworkManagerImpl.apiKey),
                                    URLQueryItem(name: NetworkManagerImpl.languageParam, value: UserDefaultManager.shared.getLanguage())]
        fetcher.send(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    func getListOfMovie(id: Int, completionHandler: @escaping (Result<MovieList, Error>) -> Void) {
        urlComponents = URLComponents(string: "\(NetworkUrl.getListOfMovieByGenreId.rawValue)/\(String(id))")!
        
        urlComponents.queryItems = [URLQueryItem(name: NetworkManagerImpl.apiKeyParam, value: NetworkManagerImpl.apiKey),
                                    URLQueryItem(name: NetworkManagerImpl.languageParam, value: UserDefaultManager.shared.getLanguage())]
        fetcher.send(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    func getMovieById(id: Int, completionHandler: @escaping (Result<MovieDescription, Error>) -> Void) {
        urlComponents = URLComponents(string: "\(NetworkUrl.getMovieDescriptionByMovieId.rawValue)\(String(id))")!
        
        urlComponents.queryItems = [URLQueryItem(name: NetworkManagerImpl.apiKeyParam, value: NetworkManagerImpl.apiKey),
                                    URLQueryItem(name: NetworkManagerImpl.languageParam, value: UserDefaultManager.shared.getLanguage())]
        print(urlComponents.url!)
        fetcher.send(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    func getMoviePoster(path: String) -> Data {
        urlComponents = URLComponents(string: "\(NetworkUrl.getMoviePostImage.rawValue)w\( UserDefaultManager.shared.getPixelSize()!)/\(String(path))")!
        
        guard let data = try? Data(contentsOf: urlComponents.url!) else {
            return Data()
        }
        return data
    }
}
