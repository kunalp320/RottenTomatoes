//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Kunal Patel on 2/16/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {


    @IBOutlet weak var moviesTableView: UITableView!
    var configurations: APIConfiguration = APIConfiguration()
    var movies = [NSDictionary]()
    var endpoint: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        let url = NSURL(string:configurations.baseUrl + endpoint + "?api_key=\(configurations.apiKey)")
        let request = NSURLRequest(URL: url!)
        
        // configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                        self.movies = responseDictionary["results"] as! [NSDictionary]
                        self.moviesTableView.reloadData()
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies:[NSDictionary] = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    private func displayMoviePoster(movie: NSDictionary, withCell: MovieCell) {
        if let poster_path = movie["poster_path"] {
            let imageURL = NSURL(string: self.configurations.baseLowResolutionImageURL + (poster_path as! String))
            let imageURLRequest = NSURLRequest(URL: imageURL!)
            
            withCell.moviePosterImage.setImageWithURLRequest(imageURLRequest, placeholderImage: nil,
                success: { (imageRequest, imageResponse, smallImage) -> Void in
                    withCell.moviePosterImage?.alpha = 0.8
                    withCell.moviePosterImage?.image = smallImage
                    UIView.animateWithDuration(0.9, animations: { () -> Void in
                        withCell.moviePosterImage?.alpha = 1.0
                        }, completion: {(success) -> Void in
                            let highResImageURL = NSURL(string: self.configurations.baseHighResolutionImageURL + (poster_path as! String))
                            let highResImageURLRequest = NSURLRequest(URL: highResImageURL!)
                            withCell.moviePosterImage.setImageWithURLRequest(highResImageURLRequest, placeholderImage: nil, success: { (highResImageRequest, highRestImageResponse, highResImage) -> Void in
                                withCell.moviePosterImage.alpha = 1.0
                                withCell.moviePosterImage.image = highResImage
                                }, failure: { (request, response, error) -> Void in
                            })
                    })
                },
            
                failure: { (request, response, error) -> Void in
                });
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell

        let movie = self.movies[indexPath.row]
        
        displayMoviePoster(movie, withCell:cell)
        
        cell.descriptionLabel.text = movie["overview"] as? String
        cell.movieTitleLabel.text = movie["title"] as? String


        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = self.moviesTableView.indexPathForCell(cell)
        
        let movie = movies[indexPath!.row]
        let movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
        movieDetailViewController.movie = movie
    }


}

