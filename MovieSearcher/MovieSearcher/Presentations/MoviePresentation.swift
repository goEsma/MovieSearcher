//
//  MoviePresentation.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation

///Presentation of `Movie` object.
final class MoviePresentation: NSObject {
    let title: String
    let year: String
    let type: String
    
    init(title:String, year:String, type:String) {
        self.title = title
        self.year = year
        self.type = type
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? MoviePresentation else { return false }
        return self.title == other.title && self.type == other.type && self.year == other.year
    }
}

