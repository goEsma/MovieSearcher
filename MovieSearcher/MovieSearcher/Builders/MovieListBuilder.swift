//
//  MovieListBuilder.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

///Builds a `MovieListViewController`, and injects dependencies.
final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        let viewController = Storyboard.Main.instantiateViewController(withIdentifier: ViewController.Identifier.MovieList) as! MovieListViewController
        viewController.viewModel = MovieListViewModel(service: app.service)
        return viewController
    }
}
