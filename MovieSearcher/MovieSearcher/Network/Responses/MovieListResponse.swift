//
//  MovieListResponse.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

///Response object that decodes the list of movies fetched from the OMdb.
struct MovieListResponse: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case search = "Search"
    }

    let movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.movies = try rootContainer.decode([Movie].self, forKey: .search)
    }
    
}
