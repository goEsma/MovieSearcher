//
//  AppContainer.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

let app = AppContainer()

///Contains common dependencies.
final class AppContainer {
    let router = AppRouter()
    let service = ImdbService()
}
