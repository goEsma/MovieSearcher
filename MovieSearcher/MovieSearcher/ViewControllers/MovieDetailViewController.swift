//
//  MovieDetailViewController.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
