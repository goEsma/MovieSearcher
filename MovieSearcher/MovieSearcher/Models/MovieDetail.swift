//
//  MovieDetail.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

/// The model that contains details of the selected movie.
struct MovieDetail: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case runTime = "Runtime"
        case rated = "Rated"
        case director = "Director"
        case plot = "Plot"
        case posterUrl = "Poster"
    }
    
    var title:String
    var year:String
    var genre:String
    var runTime:String
    var rated:String
    var director:String
    var plot:String
    var posterUrl:String
    
}
