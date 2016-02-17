
//
//  MovieDetailViewController.swift
//  RottenTomatoes
//
//  Created by Kunal Patel on 2/17/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    let baseImageUrl = "http://image.tmdb.org/t/p/w500"
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieOverviewLabel.text = movie["overview"] as? String
        self.movieTitleLabel.text = movie["title"] as? String
        
        let imageUrl = NSURL(string: self.baseImageUrl + (movie["poster_path"] as! String))
        posterImageView.setImageWithURL(imageUrl!)
        
    }
    
}
