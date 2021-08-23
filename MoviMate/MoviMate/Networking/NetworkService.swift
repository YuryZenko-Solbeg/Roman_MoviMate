//
//  NetworkService.swift
//  MoviMate
//
//  Created by Roman Alikevich on 10.08.21.
//

import UIKit

protocol NetworkService {
    
    func send(url: URL, complitionHandler: @escaping (Result<Data, Error>)  -> Void)
}

class NetworkServiceImpl: NetworkService {
    
    func send(url: URL, complitionHandler: @escaping (Result<Data, Error>) -> Void) {
 
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let data = data {
                
                complitionHandler(.success(data))
            } else {
                
                complitionHandler(.failure(NilPointerError.internetNoValid(message: "Please, check connection to internet")))
            }
            
            if let error = error {
                
                complitionHandler(.failure(error))
            }
            
        }).resume()
    }
}
