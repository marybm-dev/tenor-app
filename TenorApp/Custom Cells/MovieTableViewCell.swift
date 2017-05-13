//
//  MovieTableViewCell.swift
//  TenorApp
//
//  Created by Mary Martinez on 5/13/17.
//  Copyright © 2017 Mary Martinez. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var favoritedImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            self.movieNameLabel.text = movie.name
            self.movieDescriptionLabel.text = movie.desc
            self.favoritedImageView.image = #imageLiteral(resourceName: "heartUnfilled")
            
            // attempt to load image
            if let imagePath = movie.image {
                do {
                    let imageData = try Data(contentsOf: imagePath)
                    self.movieImageView.image = UIImage(data: imageData)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
