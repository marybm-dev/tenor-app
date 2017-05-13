//
//  ViewController.swift
//  TenorApp
//
//  Created by Mary Martinez on 5/13/17.
//  Copyright © 2017 Mary Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var endPoint: MovieEndPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieClient.movies(endPoint: .criticRatings) { [weak self] (movies: [Movie]?, error: Error?) in
            
            if let theMovies = movies {
                self?.movies = theMovies
            
                
            } else {
                // display alert dialog that says the data was not found
                let alertController = UIAlertController(title: "Uh oh. Something went wrong", message: "Couldn't get movie data.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
}
