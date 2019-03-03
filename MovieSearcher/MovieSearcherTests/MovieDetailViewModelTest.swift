//
//  MovieDetailViewModelTest.swift
//  MovieSearcherTests
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import XCTest
@testable import MovieSearcher

class MovieDetailViewModelTest: XCTestCase {

    private var view: MockView!
    private var viewModel: MovieDetailViewModel!
    private var service: MockImdbService!
    
    override func setUp() {
        service = MockImdbService()
        viewModel = MovieDetailViewModel(service: service, imdbId:"tt3766394")
        view = MockView()
        viewModel.delegate = view
    }
    
    func testLoadMovieDetail() throws {
        //Given:
        let movieDetail1 = try ResourceLoader.loadMovieDetail(resource: .movieDetail1)
        service.movieDetail = movieDetail1
        
        //When:
        viewModel.loadDetails()
        
        //Then:
        XCTAssertEqual(view.outputs.count, 3)
        
        XCTAssertEqual(try view.outputs.element(at: 0), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(false))
        
        let expectedMoviePresentation = MovieDetailPresentation(details: movieDetail1)
        XCTAssertEqual(try view.outputs.element(at: 2), .showDetail(expectedMoviePresentation))
    }

}

private class MockView: MovieDetailViewModelDelegate {
    var outputs: [MovieDetailViewModelOutput] = []
    
    func handleViewModel(output: MovieDetailViewModelOutput) {
        outputs.append(output)
    }
}
