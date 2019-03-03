//
//  MovieListViewController.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    @IBOutlet weak var titleSearchBar: UISearchBar!
    @IBOutlet weak var yearSearchBar: UISearchBar!
    @IBOutlet weak var typeSearchBar: UISearchBar!
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    private var movieList: [MoviePresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register((UINib(nibName: "MovieTableViewCell", bundle: nil)), forCellReuseIdentifier: "MovieTableViewCell")

    }

}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func handleViewModel(output: MovieListViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showMovieList(let movieList):
            self.movieList = movieList
            tableView.reloadData()
        }
    }
    
    func navigate(to route: MovieListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = MovieDetailBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }

}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {fatalError("Cell cannot be found!")}
        cell.setup(movie: movieList[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.selectMovie(at: indexPath.row)
    }
}


//MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.frame = CGRect(x: 0.0, y: -80.0, width: 0.0, height: 44.0)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let title = titleSearchBar.text, title != "" else {
            print("error must enter title")
            // Show an alert message. 
            return
        }
        let type = typeSearchBar.text
        let year = yearSearchBar.text
        viewModel.loadMovies(for: title, year: year, type: type)
        searchBar.resignFirstResponder()
    }
    
}
