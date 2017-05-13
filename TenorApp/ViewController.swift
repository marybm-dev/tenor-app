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
    
    var movies = [Movie]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var endPoint: MovieEndPoint! {
        didSet {
            self.loadData()
        }
    }
    let segmentControl = UISegmentedControl()
    var segmentBarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSetmentControl()
        self.endPoint = .userRatings
    }
    
    func initSetmentControl() {
        segmentControl.frame = CGRect(x: 0, y: 0, width: 180, height: 30.0)
        segmentControl.insertSegment(withTitle: "User Ratings", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Critic Ratings", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlAction(segmentControl:)), for: .valueChanged)
        segmentBarItem = UIBarButtonItem(customView: segmentControl)
        self.navigationItem.rightBarButtonItem = segmentBarItem
    }

    func segmentControlAction(segmentControl: UISegmentedControl) {
        self.endPoint = segmentControl.selectedSegmentIndex == 0 ? .userRatings : .criticRatings
    }
    
    func loadData() {
        MovieClient.movies(endPoint: self.endPoint) { [weak self] (endPointMovies: [Movie]?, error: Error?) in
            
            if let theMovies = endPointMovies {
                let oldMovies = self?.movies
                var newMovies = [Movie]()
                
                // retain the existing Movies and add the new new ones
                for movie in theMovies {
                    if (oldMovies?.contains(where: {
                        if $0.id == movie.id {
                            newMovies.append($0)
                        }
                        return $0.id == movie.id
                        
                    }))! { } else {

                        newMovies.append(movie)
                    }
                }
                
                self?.movies = newMovies

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
