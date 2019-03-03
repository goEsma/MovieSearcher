//
//  MovieDetailPresentation+API.swift
//  MovieSearcher
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

extension MovieDetailPresentation {
    //convenient initalizer is created to enable initializing the presentation object with a single parameter.
    convenience init(details: MovieDetail) {
        self.init(title: details.title, year: details.year, genre: details.genre, runTime: details.runTime, rated: details.rated, director: details.director, plot: details.plot, posterUrl: details.posterUrl)
    }
}
