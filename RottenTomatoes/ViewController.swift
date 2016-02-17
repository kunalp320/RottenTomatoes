//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Kunal Patel on 2/16/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    var movie: Movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movie = Movies()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie: NSDictionary = self.movie.nowPlaying(indexPath.row)
        
        cell.descriptionLabel?.text = movie["overview"] as? String
        cell.movieTitleLabel.text = movie["title"] as? String
        return cell
        
    }


}

