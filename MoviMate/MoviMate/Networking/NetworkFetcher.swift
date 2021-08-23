//
//  NetworkFetcher.swift
//  MoviMate
//
//  Created by Roman Alikevich on 11.08.21.
//

import Foundation

protocol NetworkFetcher {
    
    func send<R: Codable>(url: URL, completionHandler: @escaping (Result<R, Error>) -> Void)
}

class NetworkFetcherImpl: NetworkFetcher {
    
    var service: NetworkService!
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func send<R: Codable>(url: URL, completionHandler: @escaping (Result<R, Error>) -> Void) {
        
        service.send(url: url) { (requestValue) in

            switch requestValue {
            
            case .success(let data):
                
            let decoder = JSONDecoder()
                
            guard let resultObject = try? decoder.decode(R.self, from: data) else {
                completionHandler(.failure(NilPointerError.invalidRequest(message: "There's parsing error!")))
                    
                    return
            }
                
                completionHandler(.success(resultObject))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
