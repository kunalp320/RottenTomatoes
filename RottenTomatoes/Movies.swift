//
//  Movies.swift
//  RottenTomatoes
//
//  Created by Kunal Patel on 2/17/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class Movies: NSObject {
    
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let baseUrl =  "https://api.themoviedb.org/3/movie/"
    var movies = [NSDictionary]()
    
    override init() {
        super.init()
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
                    }
                }
        });
        task.resume()
    }
    
    func nowPlaying(movie: Int) -> NSDictionary {
        return self.movies[movie]
    }
    
}
