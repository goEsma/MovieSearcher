//
//  Movie.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

/// The model that contains basic movie information.
struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case imdbID
    }
    
    var title:String
    var year:String
    var type:String
    var imdbID:String
}
