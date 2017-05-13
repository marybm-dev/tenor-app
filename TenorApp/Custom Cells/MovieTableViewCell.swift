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
    
    weak var tableView: UITableView!
    
    var movie: Movie! {
        didSet {
            self.movieNameLabel.text = movie.name
            self.movieDescriptionLabel.text = movie.desc
            
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
            
            // register for changes
            addObserver(self, forKeyPath: #keyPath(movie.favorited), options: [.old, .new], context: nil)
        }
    }

    @IBAction func didTapFavoriteButton(_ sender: Any) {
        self.movie.favorited = !self.movie.favorited
        self.favoriteButton.setImage(imageToUse(), for: .normal)
    }
    
    func imageToUse() -> UIImage {
        return self.movie.favorited ? #imageLiteral(resourceName: "heart_filled_outline") : #imageLiteral(resourceName: "heartUnfilled")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(movie.favorited) {
            self.favoriteButton.setImage(imageToUse(), for: .normal)
        }
    }
    
    override func prepareForReuse() {
        removeObserver(self, forKeyPath: #keyPath(movie.favorited))
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(movie.favorited))
    }
}
