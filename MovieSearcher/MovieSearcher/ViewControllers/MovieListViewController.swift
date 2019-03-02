//
//  MovieListViewController.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var service: ImdbService!
}

//extension MovieListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//
//}

extension MovieListViewController: UITableViewDelegate {
    
}
