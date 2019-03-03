//
//  MovieDetailContracts.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? { get set }
    func loadDetails()
    func loadPoster(url:String)
}

///List of outputs that the viewModel sends to the viewController object.
enum MovieDetailViewModelOutput: Equatable {
    case setLoading(Bool)
    case showDetail(_ presentation: MovieDetailPresentation)
}

/**
 Delegate of the MovieDetailViewModel.
 # Conformes must comply listed features:
 - `handleViewModel(output)`
 */
protocol MovieDetailViewModelDelegate: class {
    func handleViewModel(output: MovieDetailViewModelOutput)
}
