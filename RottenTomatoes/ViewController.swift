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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell

        let movie = self.movies[indexPath.row]
        let imageUrl = NSURL(string: self.configurations.baseImageUrl + (movie["poster_path"] as! String))
        
        cell.descriptionLabel.text = movie["overview"] as? String
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.moviePosterImage.setImageWithURL(imageUrl!)

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

