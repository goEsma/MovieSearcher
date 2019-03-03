//
//  MovieDetailBuilder.swift
//  MovieSearcher
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

///Builds a `MovieDetailViewController`, and injects dependencies.
final class MovieDetailBuilder {
    static func make(with viewModel: MovieDetailViewModelProtocol) -> MovieDetailViewController {
        let viewController = Storyboard.Main.instantiateViewController(withIdentifier: ViewController.Identifier.MovieDetail) as! MovieDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
