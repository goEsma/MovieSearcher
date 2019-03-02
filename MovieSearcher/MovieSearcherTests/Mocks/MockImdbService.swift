//
//  MockImdbService.swift
//  MovieSearcherTests
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation
@testable import MovieSearcher

final class MockImdbService: ImdbServiceProtocol {
    
    var movies: [Movie] = []
    
    func fetchMovies(title: String, year: String?, type: String?, completion: @escaping (Result<MovieListResponse>) -> Void) {
        completion(.success(MovieListResponse(movies: movies)))
    }
    
    
}
