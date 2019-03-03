//
//  MovieDetailViewController.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var rated: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var plot: UITextView!
    
    //default poster height is 0.
    @IBOutlet weak var posterHeightContraint: NSLayoutConstraint!
    private let posterHeight:CGFloat = 180.0
    
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

// MARK: - MovieDetailViewModelDelegate
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func handleViewModel(output: MovieDetailViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showDetail(let presentation):
            self.showDetail(presentation)
        case .showEmptyDetail():
            let action = UIAlertAction(title: Constants.Actions.Ok, style: .default)
            displayAlert(with: Constants.ErrorTitle, message: Constants.MovieDetail.Errors.NoDetails, actions: [action])
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

        guard presentation.posterUrl != "N/A" else {return}
        
        if let url = URL(string: presentation.posterUrl) {
            posterView.af_setImage(withURL: url)
            
            //animate poster height.
            posterHeightContraint.constant = posterHeight
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
