//
//  XCUIApplication+Helper.swift
//  MovieSearcherUITests
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingMovieList: Bool {
        return otherElements["movieListView"].exists
    }
}
