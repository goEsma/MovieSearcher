//
//  MovieDetailPresentation.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

final class MovieDetailPresentation: NSObject {
    var title:String
    var year:String
    var genre:String
    var runTime:String
    var rated:String
    var director:String
    var plot:String
    var posterUrl:String
    
    init(title:String, year:String, genre:String, runTime:String, rated:String, director:String, plot:String, posterUrl:String) {
        self.title = title
        self.year = year
        self.genre = genre
        self.runTime = runTime
        self.rated = rated
        self.director = director
        self.plot = plot
        self.posterUrl = posterUrl
        
        super.init()
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? MovieDetailPresentation else { return false }
        return self.title == other.title && self.year == other.year && self.genre == other.genre && self.runTime == other.runTime && self.rated == other.rated && self.director == other.director && self.plot == other.plot && self.posterUrl == other.posterUrl
    }
}


