//
//  Router.swift
//  MovieSearcher
//
//  Created by Esma on 3/2/19.
//  Copyright © 2019 Esma. All rights reserved.
//

import Foundation
import Alamofire

public enum Router: URLRequestConvertible {
    
    enum Constants {
        static let baseURLPath = "http://www.omdbapi.com/"
        static let apiKey = "7ef7d212"
    }
    
    case movie(title:String, type:String?, year:String?)
    
    var method:HTTPMethod {
        switch self {
        case .movie:
            return .get
        }
    }
    
    var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    var parameters:[String: Any] {
        var params = ["apiKey" : Constants.apiKey as Any]
        
        switch self {
        case .movie(let title, let type, let year):
            params["s"] = title as Any
            params["type"] = type ?? "" as Any
            params["y"] = year ?? "" as Any
        }
        return params
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

