//
//  MovieViewModelTest.swift
//  MovieSearcherTests
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import XCTest
@testable import MovieSearcher

class MovieViewModelTest: XCTestCase {
    
    private var view: MockView!
    private var viewModel: MovieListViewModel!
    private var service: MockImdbService!
    
    override func setUp() {
        service = MockImdbService()
        viewModel = MovieListViewModel(service: service)
        view = MockView()
        viewModel.delegate = view
    }
    
    
    func testLoadMovies() throws {
        //Given:
        let movie1 = try ResourceLoader.loadMovie(resource: .movie1)
        let movie2 = try ResourceLoader.loadMovie(resource: .movie2)
        let movie3 = try ResourceLoader.loadMovie(resource: .movie3)
        service.movies = [movie1, movie2, movie3]
        
        //When:
        viewModel.loadMovies(for: movie1.title, year: movie1.year, type: movie1.type)
        
        //Then:
        XCTAssertEqual(view.outputs.count, 3)
        
        XCTAssertEqual(try view.outputs.element(at: 0), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(false))
        
        let expectedMovies = [movie1, movie2, movie3].map({ MoviePresentation(movie: $0) })
        XCTAssertEqual(try view.outputs.element(at: 2), .showMovieList(expectedMovies))
    }
    
}

private class MockView: MovieListViewModelDelegate {
    
    var outputs: [MovieListViewModelOutput] = []
    
    func handleViewModel(output: MovieListViewModelOutput) {
        outputs.append(output)
    }
    
    
}
