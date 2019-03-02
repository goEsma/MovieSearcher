//
//  ImdbService.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation
import Alamofire

protocol ImdbServiceProtocol {
    func fetchMovies(title:String, year:String?, type:String?, completion:  @escaping (Result<MovieListResponse>) -> Void)
}

class ImdbService: ImdbServiceProtocol {
    
    enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    func fetchMovies(title: String, year: String?, type: String?, completion: @escaping (Result<MovieListResponse>) -> Void) {
        request(Router.movie(title: title, type: type, year: year)).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MovieListResponse.self, from: data)
                    completion(.success(response))
                }catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
    
}

