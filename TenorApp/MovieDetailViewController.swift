//
//  MovieDetailViewController.swift
//  TenorApp
//
//  Created by Mary Martinez on 5/13/17.
//  Copyright © 2017 Mary Martinez. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieLongDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieNameLabel.text = movie.name
        movieLongDescriptionLabel.text = movie.longDesc
        favoriteButton.setImage(imageToUse(), for: .normal)
    }
    
    @IBAction func didTapReturnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        self.movie.favorited = !self.movie.favorited
        self.favoriteButton.setImage(imageToUse(), for: .normal)
    }
    
    func imageToUse() -> UIImage {
        return self.movie.favorited ? #imageLiteral(resourceName: "heart_filled_outline") : #imageLiteral(resourceName: "heartUnfilled")
    }
}
