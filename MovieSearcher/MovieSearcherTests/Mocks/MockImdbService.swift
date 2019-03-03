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
    var movieDetail: MovieDetail = MovieDetail(title: "", year: "", genre: "", runTime: "", rated: "", director: "", plot: "", posterUrl: "")
    
    func fetchMovies(title: String, year: String?, type: String?, page:Int, completion: @escaping (Result<MovieListResponse>) -> Void) {
        completion(.success(MovieListResponse(movies: movies)))
    }
    
    func getMovieDetail(with id: String, completion: @escaping (Result<MovieDetailResponse>) -> Void) {
        completion(.success(MovieDetailResponse(movieDetail: movieDetail)))
    }
    
}
