//
//  Movie.swift
//  TenorApp
//
//  Created by Mary Martinez on 5/13/17.
//  Copyright © 2017 Mary Martinez. All rights reserved.
//

import Foundation

class Movie {
    var id: Int
    var name: String
    var image: URL
    var desc: String
    var longDesc: String
    var favorited: Bool = false
    
    init(json: NSDictionary) {
        id = json["id"] as! Int
        name = json["name"] as! String
        image = URL(fileURLWithPath: (json["image"] as! String))
        desc = json["desc"] as! String
        longDesc = json["long_desc"] as! String
    }
}
