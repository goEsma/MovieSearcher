//
//  AppRouter.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

final class AppRouter {
    let window:UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let moviesVC = MovieListBuilder.make()
        let navigationController = UINavigationController(rootViewController: moviesVC)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
