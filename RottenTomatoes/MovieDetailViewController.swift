
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

    @IBOutlet weak var movieInfoView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var movie: NSDictionary!
    var configurations:APIConfiguration = APIConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: movieInfoView.frame.origin.y + movieInfoView.frame.size.height)
        
        self.movieOverviewLabel.text = movie["overview"] as? String
        self.movieOverviewLabel.sizeToFit()
        
        self.movieTitleLabel.text = movie["title"] as? String
        
        if let poster_path = movie["poster_path"] {
            let imageURL = NSURL(string: self.configurations.baseLowResolutionImageURL + (poster_path as! String))
            let imageURLRequest = NSURLRequest(URL: imageURL!)
            
            self.posterImageView.setImageWithURLRequest(imageURLRequest, placeholderImage: nil,
                success: { (imageRequest, imageResponse, smallImage) -> Void in
                    self.posterImageView?.alpha = 1.0
                    self.posterImageView?.image = smallImage
            
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.posterImageView.alpha = 1.0
                        }, completion: {(success) -> Void in
                            let highResImageURL = NSURL(string: self.configurations.baseHighResolutionImageURL + (poster_path as! String))
                            let highResImageURLRequest = NSURLRequest(URL: highResImageURL!)
                            self.posterImageView.setImageWithURLRequest(highResImageURLRequest, placeholderImage: nil, success: { (highResImageRequest, highRestImageResponse, highResImage) -> Void in
                                self.posterImageView.alpha = 1.0
                                self.posterImageView.image = highResImage
                                }, failure: { (request, response, error) -> Void in
                                })
                    })
                },
                
                failure: { (request, response, error) -> Void in
            });
        }
        
    }
    
}
