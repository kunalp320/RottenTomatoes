
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
    var movie: NSDictionary!
    var configurations:APIConfiguration = APIConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieOverviewLabel.text = movie["overview"] as? String
        self.movieTitleLabel.text = movie["title"] as? String
        
        let imageUrl = NSURL(string: configurations.baseImageUrl + (movie["poster_path"] as! String))
        posterImageView.setImageWithURL(imageUrl!)
        
    }
    
}
