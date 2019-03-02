//
//  MovieTest.swift
//  MovieSearcherTests
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import XCTest

@testable import MovieSearcher
class MovieTest: XCTestCase {

    func testParsing () throws {
        let bundle = Bundle(for: MovieTest.self)
        guard let url = bundle.url(forResource: "movie", withExtension: "json") else {
            XCTFail("movie resouce cannot be found.")
            return
        }
        let data = try Data(contentsOf: url)
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        
        XCTAssertEqual(movie.title, "Hello, My Name Is Doris")
        XCTAssertEqual(movie.year, "2015")
        XCTAssertEqual(movie.type, "movie")
    }
    
}
