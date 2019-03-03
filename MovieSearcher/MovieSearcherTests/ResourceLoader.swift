//
//  ResourceLoader.swift
//  MovieSearcherTests
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieSearcher

class ResourceLoader {
    
    enum MovieResource: String {
        case movie1
        case movie2
        case movie3
    }
    
    enum MovieDetailResource: String {
        case movieDetail1
    }
    
    static func loadMovie(resource: MovieResource) throws -> Movie {
        let bundle = Bundle.test
        guard let url = bundle.url(forResource: resource.rawValue, withExtension: "json") else {
            XCTFail("\(resource.rawValue) resource cannot be found.")
            return Movie(title: "", year: "", type: "", imdbID: "")
        }
        let data = try Data(contentsOf: url)
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        return movie
    }
    
    static func loadMovieDetail(resource: MovieDetailResource) throws -> MovieDetail {
        let bundle = Bundle.test
        guard let url = bundle.url(forResource: resource.rawValue, withExtension: "json") else {
            XCTFail("\(resource.rawValue) resource cannot be found.")
            return MovieDetail(title: "", year: "", genre: "", runTime: "", rated: "", director: "", plot: "", posterUrl: "")
        }
        let data = try Data(contentsOf: url)
        let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
        return movieDetail
    }
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
