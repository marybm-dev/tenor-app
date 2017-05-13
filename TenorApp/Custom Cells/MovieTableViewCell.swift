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
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie: Movie! {
        didSet {
            self.movieNameLabel.text = movie.name
            self.movieDescriptionLabel.text = movie.desc
            self.favoriteButton.imageView?.image = #imageLiteral(resourceName: "heartUnfilled")
            
            // attempt to load image
            if let imagePath = movie.image {
                do {
                    let imageData = try Data(contentsOf: imagePath)
                    self.movieImageView.image = UIImage(data: imageData)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            // display the correct favorite heart
            self.favoriteButton.setImage(imageToUse(), for: .normal)
        }
    }

    @IBAction func didTapFavoriteButton(_ sender: Any) {
        self.movie.favorited = !self.movie.favorited
        self.favoriteButton.setImage(imageToUse(), for: .normal)
    }
    
    func imageToUse() -> UIImage {
        return self.movie.favorited ? #imageLiteral(resourceName: "heart_filled_outline") : #imageLiteral(resourceName: "heartUnfilled")
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
