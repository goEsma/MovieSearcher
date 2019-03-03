//
//  MovieDetailTest.swift
//  MovieSearcherTests
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import XCTest
@testable import MovieSearcher

class MovieDetailTest: XCTestCase {

    func testParsing () throws {
        let bundle = Bundle(for: MovieDetailTest.self)
        guard let url = bundle.url(forResource: "movieDetail1", withExtension: "json") else {
            XCTFail("movie resouce cannot be found.")
            return
        }
        let data = try Data(contentsOf: url)
        let details = try JSONDecoder().decode(MovieDetail.self, from: data)
        
        XCTAssertEqual(details.title, "Hello, My Name Is Doris")
        XCTAssertEqual(details.year, "2015")
        XCTAssertEqual(details.genre, "Comedy, Drama, Romance")
        XCTAssertEqual(details.runTime, "90 min")
        XCTAssertEqual(details.rated, "R")
        XCTAssertEqual(details.director, "Michael Showalter")
        XCTAssertEqual(details.plot, "A self-help seminar inspires a sixty-something woman to romantically pursue her younger co-worker.")
        XCTAssertEqual(details.posterUrl, "https://m.media-amazon.com/images/M/MV5BMTg0NTM3MTI1MF5BMl5BanBnXkFtZTgwMTAzNTAzNzE@._V1_SX300.jpg")
    }
    
}
