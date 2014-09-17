//
//  movieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by isai on 9/14/14.
//  Copyright (c) 2014 isai. All rights reserved.
//

import UIKit

class movieDetailsViewController: UIViewController {

    @IBOutlet weak var moviePosterView: UIImageView!

    @IBOutlet weak var movieScrollView: UIScrollView!
    
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var synopsis: UILabel!

    
    var synopsisString = ""
    var posterURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        moviePosterView.setImageWithURL(NSURL(string: posterURL))
        synopsis.text = synopsisString
        synopsis.sizeToFit()
        descriptionView.frame.size.height = synopsis.frame.size.height + synopsis.frame.origin.y
        movieScrollView.contentSize = CGSize(width:320, height: synopsis.frame.size.height + synopsis.frame.origin.y)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
