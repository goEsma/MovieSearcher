//
//  MovieListViewController.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var titleSearchBar: UISearchBar!
    @IBOutlet weak var yearSearchBar: UISearchBar!
    @IBOutlet weak var typeSearchBar: UISearchBar!
    @IBOutlet weak var typePicker: UIPickerView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var pickerList = ["movie", "episode", "series"]

    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    private var movieList: [MoviePresentation] = []

    private enum LoadType {
        case loadFirst
        case loadNext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register((UINib(nibName: Cell.NibName.Movie, bundle: nil)), forCellReuseIdentifier: Cell.Identifier.Movie)

        let searchButton = UIBarButtonItem(title: Constants.MovieList.BarButton.Search, style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton

    }
    
    @objc func searchButtonTapped() {
 
        loadData(with: .loadFirst)
        
        self.resignFirstResponder()
        self.view.endEditing(true)
        
    }

    private func loadData(with loadAction: LoadType){
        guard let title = titleSearchBar.text, let year = yearSearchBar.text, let type = typeSearchBar.text else { return }
        let validation = viewModel.validateEntries(title: title, year: year, type: type)
        switch validation {
        case .valid:
            switch loadAction{
            case .loadFirst:
                viewModel.loadMovies(for: title, year: year, type: type, page:1)
            case .loadNext:
                viewModel.shouldLoadNextPage(title: title, type: type, year: year)
            }
        case .invalidYear:
            let action = UIAlertAction(title: Constants.Actions.Ok, style: .default)
            self.displayAlert(with: Constants.ErrorTitle, message: Constants.MovieList.Errors.ValidYear, actions: [action])
        case .invalidTitle:
            let action = UIAlertAction(title: Constants.Actions.Ok, style: .default)
            displayAlert(with: Constants.ErrorTitle, message: Constants.MovieList.Errors.NeedToEnterTitle, actions: [action])
        }
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
        case .showEmptyList():
            self.movieList = []
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.Identifier.Movie, for: indexPath) as? MovieTableViewCell else {fatalError(Constants.MovieList.Errors.NoCellFound)}
        cell.setup(movie: movieList[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.movieList.count == 0 {
            return Constants.MovieList.NoMovies
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.movieList.count == 0 {
            return UIView()
        }
        return nil
    }

}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.selectMovie(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // return if another service is on call.
        guard !UIApplication.shared.isNetworkActivityIndicatorVisible else { return }
        
        // check if the cell is the last one
        if indexPath.row == movieList.count - 1 {
            self.loadData(with: .loadNext)
        }
    }
}


//MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == typeSearchBar {
            self.typePicker.isHidden = false
            searchBar.resignFirstResponder()
        }else {
            searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.frame = CGRect(x: 0.0, y: -80.0, width: 0.0, height: 44.0)
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
        searchBar.text = ""
        if searchBar == typeSearchBar {
            self.typePicker.isHidden = true
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonTapped()
        self.view.endEditing(true)
    }
    
}

extension MovieListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    
}

extension MovieListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeSearchBar.text = self.pickerList[row]
        self.typePicker.isHidden = true
    }
}

