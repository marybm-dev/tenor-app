//
//  MovieClient.swift
//  TenorApp
//
//  Created by Mary Martinez on 5/13/17.
//  Copyright © 2017 Mary Martinez. All rights reserved.
//

import Foundation

enum MovieEndPoint {
    case userRatings
    case criticRatings
}

enum MovieError: Error {
    case jsonNotFound
}

class MovieClient {
    
    static func movies(endPoint: MovieEndPoint, completion: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void) {
        guard let movies = self.readJson(endPoint: endPoint) else {
            completion(nil, MovieError.jsonNotFound)
            return
        }
        
        completion(movies, nil)
    }
    
    static func readJson(endPoint: MovieEndPoint) -> [Movie]? {
        var movies = [Movie]()
        var filepath: String?
        
        // read the appropriate file
        switch endPoint {
        case .userRatings:
            filepath = Bundle.main.path(forResource: "Films-critic", ofType: "json")
        case .criticRatings:
            filepath = Bundle.main.path(forResource: "Films-user", ofType: "json")
        }
        
        // bail out if file not found
        guard let file = filepath else {
            return nil
        }
        
        // get the json data
        do {
            let fileURL = URL(fileURLWithPath: file)
            let data = try Data(contentsOf: fileURL)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            if let jsonDict = json as? [AnyObject] {
                for movie in jsonDict {
                    if let currentMovieDictionary = movie as? NSDictionary {
                        movies.append(Movie(json: currentMovieDictionary))
                    }
                }
                
            } else {
                return nil
            }
            
        } catch {
            return nil
        }
        
        return movies
    }
    
}
