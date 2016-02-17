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
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let baseUrl =  "https://api.themoviedb.org/3/movie/"
    let baseImageUrl = "http://image.tmdb.org/t/p/w500"
    var movies = [NSDictionary]()
    var endpoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        let url = NSURL(string:baseUrl + "now_playing" + "?api_key=\(apiKey)")
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell

        let movie = self.movies[indexPath.row]
        let imageUrl = NSURL(string: self.baseImageUrl + (movie["poster_path"] as! String))
        
        cell.descriptionLabel.text = movie["overview"] as? String
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.moviePosterImage.setImageWithURL(imageUrl!)

        return cell
    }


}

