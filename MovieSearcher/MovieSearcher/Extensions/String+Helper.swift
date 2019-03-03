//
//  String+Helper.swift
//  MovieSearcher
//
//  Created by Esma on 3/3/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

extension String {
    
    ///Converts the strings with "N/A" to empty string "".
    func withoutNA() -> String {
        if self == "N/A" {
            return ""
        }
        return self
    }
}
