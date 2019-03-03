//
//  MovieDetailViewController.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var rated: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var plot: UITextView!
    
    //Will be injected upon creation of this class.
    var imdbId:String!
    var viewModel: MovieDetailViewModelProtocol!{
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func handleViewModel(output: MovieDetailViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showDetail(let presentation):
            self.showDetail(presentation)
        }
    }
    
    
    func showDetail(_ presentation: MovieDetailPresentation) {
        movieTitle.text = presentation.title
        genre.text = presentation.genre
        director.text = presentation.director
        runtime.text = presentation.runTime
        rated.text = presentation.rated
        year.text = presentation.year
        plot.text = presentation.plot

        if let url = URL(string: presentation.posterUrl){
            posterView.af_setImage(withURL: url)
        }
    }
}
