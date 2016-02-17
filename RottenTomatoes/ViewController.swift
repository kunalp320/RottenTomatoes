//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Kunal Patel on 2/16/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        cell.descriptionLabel?.text = "WE OUT HERE"
        cell.movieTitleLabel.text = "The Revanent"
        return cell 
        
    }


}

