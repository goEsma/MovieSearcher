//
//  MovieDetailResponse.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

///Response object that decodes the selected movie details fetched from the OMdb.
struct MovieDetailResponse: Decodable {
    let movieDetail: MovieDetail
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    public init(from decoder: Decoder) throws {
        self.movieDetail = try MovieDetail(from: decoder)
    }
    
}
