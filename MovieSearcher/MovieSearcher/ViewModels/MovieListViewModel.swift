//
//  MovieListViewModel.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

final class MovieListViewModel: MovieListViewModelProtocol {
    weak var delegate: MovieListViewModelDelegate?
    private let service: ImdbServiceProtocol
    private var movies: [Movie] = []
    private var totalResult:Int = 0
    init(service: ImdbServiceProtocol) {
        self.service = service
    }
    
    private var nextPage = 1
    
    func loadMovies(for title: String, year: String?, type: String?, page:Int) {
        notify(.setLoading(true))
        service.fetchMovies(title: title, year: year, type: type, page: page) { [weak self] (response) in
            guard let `self` = self else { return }
            self.notify(.setLoading(false))
            
            switch response {
            case .success(let result):
                if page == 1 {
                    self.movies = result.movies
                }else {
                    self.movies = self.movies + result.movies
                }
                
                let presentations = self.movies.map({ MoviePresentation(title: $0.title, year: $0.year, type: $0.type) })
                self.notify(.showMovieList(presentations))
                
                if let total = Int(result.totalResult) {
                    self.totalResult = total
                }
            
            case .failure(_):
                if page == 1 {
                    self.notify(.showEmptyList())
                }                
            }
        }
    }
    
    func shouldLoadNextPage(title: String, type: String?, year: String?) {
        if totalResult > movies.count {
            nextPage += 1
            loadMovies(for: title, year: year, type: type, page: nextPage)
        }
    }
    
    func selectMovie(at index: Int) {
        let movie = movies[index]
        let viewModel = MovieDetailViewModel(service: self.service, imdbId: movie.imdbID)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    func validateEntries(title: String, year: String, type: String) -> EntryValidation  {
        guard title != "" else {
            return .invalidTitle
        }
        if Int(year) == nil && year != ""  {
            return .invalidYear
        }
        return .valid
    }
    
    private func notify(_ output: MovieListViewModelOutput) {
        delegate?.handleViewModel(output: output)
    }
    
}

enum EntryValidation {
    case valid
    case invalidTitle
    case invalidYear
}
