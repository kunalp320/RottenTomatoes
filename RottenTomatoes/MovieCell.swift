//
//  MovieCell.swift
//  RottenTomatoes
//
//  Created by Kunal Patel on 2/16/16.
//  Copyright © 2016 bootcamp. All rights reserved.
//

import UIKit
class MovieCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


