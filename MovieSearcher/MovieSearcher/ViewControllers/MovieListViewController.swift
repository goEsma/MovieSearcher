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
    @IBOutlet weak var typePicker: UIPickerView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var pickerList = ["movie", "episode", "series"]

    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    private var movieList: [MoviePresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register((UINib(nibName: "MovieTableViewCell", bundle: nil)), forCellReuseIdentifier: "MovieTableViewCell")

        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton

    }
    
    @objc func searchButtonTapped() {
        guard let title = titleSearchBar.text, title != "" else {
            print("error must enter title")
            // Show an alert message.
            return
        }
        let type = typeSearchBar.text
        let year = yearSearchBar.text
        viewModel.loadMovies(for: title, year: year, type: type)
        self.resignFirstResponder()
        self.view.endEditing(true)
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
