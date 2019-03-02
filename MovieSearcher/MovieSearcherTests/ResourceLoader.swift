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
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
