//
//  MovieListContracts.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

///The protocol of the MovieListViewModel.
protocol MovieListViewModelProtocol {
    var delegate:MovieListViewModelDelegate? { get set }
    func loadMovies()
}

///List of outputs that the viewModel sends to the viewController object.
enum MovieListViewModelOutput: Equatable {
    case setLoading(Bool)
    case showMovieList([MoviePresentation])
}

/**
 Delegate of the MovieListViewModel.
 # Conformes must comply listed features:
 - `handleViewModel(output)`
 */
protocol MovieListViewModelDelegate: class {
    func handleViewModel(output: MovieListViewModelOutput)
}
