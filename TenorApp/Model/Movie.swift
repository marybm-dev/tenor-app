//
//  Movie.swift
//  TenorApp
//
//  Created by Mary Martinez on 5/13/17.
//  Copyright © 2017 Mary Martinez. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie: NSObject {
    var id: Int?
    var name: String?
    var image: URL?
    var desc: String?
    var longDesc: String?
    dynamic var favorited: Bool = false
    
    init(json: JSON) {
        id = json["id"].int
        name = json["name"].string
        image = json["image"].url
        desc = json["desc"].string
        longDesc = json["long_desc"].string
    }
}
