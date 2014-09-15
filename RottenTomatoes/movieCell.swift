//
//  movieCell.swift
//  RottenTomatoes
//
//  Created by isai on 9/14/14.
//  Copyright (c) 2014 isai. All rights reserved.
//

import UIKit

class movieCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieView: UIImageView!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
