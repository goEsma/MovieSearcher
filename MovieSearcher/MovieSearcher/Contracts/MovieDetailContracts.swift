//
//  MovieDetailContracts.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

///The protocol of the `MovieDetailViewModel`.
protocol MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? { get set }
    func loadDetails()
}

///List of outputs that the viewModel sends to the viewController object.
enum MovieDetailViewModelOutput: Equatable {
    case setLoading(Bool)
    case showDetail(_ presentation: MovieDetailPresentation)
    case showEmptyDetail()

}

/**
 Delegate of the MovieDetailViewModel.
 # Conformes must comply listed features:
 - `handleViewModel(output)`
 */
protocol MovieDetailViewModelDelegate: class {
    func handleViewModel(output: MovieDetailViewModelOutput)
}
