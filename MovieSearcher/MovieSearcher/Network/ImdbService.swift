//
//  ImdbService.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation
import Alamofire

/// Protocol of the `ImdbService`.
protocol ImdbServiceProtocol {
    func fetchMovies(title:String, year:String?, type:String?, page:Int, completion:  @escaping (Result<MovieListResponse>) -> Void)
    
    func getMovieDetail(with id:String, completion: @escaping (Result<MovieDetailResponse>) -> Void)
}

/// Handles data requests to Imdb service.
class ImdbService: ImdbServiceProtocol {
    
    enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    func fetchMovies(title: String, year: String?, type: String?, page:Int, completion: @escaping (Result<MovieListResponse>) -> Void) {
        request(Router.movie(title: title, type: type, year: year, page: page)).responseData { (response) in
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
    
    func getMovieDetail(with id:String, completion: @escaping (Result<MovieDetailResponse>) -> Void) {
        request(Router.movieDetails(id: id)).responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MovieDetailResponse.self, from: data)
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


