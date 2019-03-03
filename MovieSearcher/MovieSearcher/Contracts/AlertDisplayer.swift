//
//  AlertDisplayer.swift
//  MovieSearcher
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import UIKit

///Enables its conformers to displayAlert with just 1-2 lines of code, includes default implementation in its extension. 
protocol AlertDisplayer {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction])
}

extension AlertDisplayer where Self: UIViewController {
    
   //Default implementation of the display alert function.
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}
