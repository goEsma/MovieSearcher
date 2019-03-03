//
//  MovieListUITest.swift
//  MovieSearcherUITests
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import XCTest

class MovieListUITest: XCTestCase {

    var app:XCUIApplication!
    
    override func setUp() {

        super.setUp()
        
        continueAfterFailure = false

        app = XCUIApplication()
        
        XCUIApplication().launch()

    }


    func testMovieListPage() {
        app.launch()
        XCTAssertTrue(app.isDisplayingMovieList)
        
    }
    
}
