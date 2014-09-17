//
//  MoviewsViewController.swift
//  RottenTomatoes
//
//  Created by isai on 9/14/14.
//  Copyright (c) 2014 isai. All rights reserved.
//

import UIKit

class MoviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var networkError: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var refreshControl: UIRefreshControl!
    
    var movies: [NSDictionary] = []
    var movie: NSDictionary!
    
    struct row {
        var currentRow: NSInteger?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        networkError.hidden = true
        searchBar.hidden = false
        searchBar.tintColor = UIColor.whiteColor()
        
        //Refresh Control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl.backgroundColor = UIColor.whiteColor()
        self.moviesTableView.addSubview(refreshControl)
        
        
        //Progress HUD
        var progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Fetching movies..."
        progressHUD.show(true)
        
        //Customize navigation controller
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let titleColor: NSDictionary = [NSForegroundColorAttributeName: UIColor.redColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleColor
        
        //Fetch movies 
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=ghb9emfcnbxfrmrdksmk95sq&limit=20&country=us"
        
        var request = NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response: NSURLResponse!, data: NSData!, error: NSError!)-> Void in
            
        if(error != nil)
        {
            self.networkError.hidden = false
            self.searchBar.hidden = true
            println("Error loading movies...")
        }
        else
        {
            self.networkError.hidden = true
            self.searchBar.hidden = false
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.movies = object["movies"] as [NSDictionary]
            
            self.moviesTableView.reloadData()
        }
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.refreshControl.endRefreshing()

            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = moviesTableView.dequeueReusableCellWithIdentifier("movieCell") as movieCell
        
        movie = movies[indexPath.row]
        
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["original"] as String
        
        var originalUrl = posterURL.stringByReplacingOccurrencesOfString("tmb", withString: "pro", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        cell.movieView.setImageWithURL(NSURL(string: originalUrl))
        
        return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func refresh(sender:AnyObject)
    {
        moviesTableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            let indexPath = self.moviesTableView.indexPathForCell(sender as UITableViewCell)
            
            var movie = movies[indexPath!.row]
            var title = movie["title"] as String
            var synopsis = movie["synopsis"] as? String
            var posters = movie["posters"] as NSDictionary
            var posterURL = posters["original"] as String
            var originalUrl = posterURL.stringByReplacingOccurrencesOfString("tmb", withString: "det", options: NSStringCompareOptions.LiteralSearch, range: nil)

            if(segue.identifier == "tableCellSegue"){
                
            var mdvc = segue.destinationViewController as movieDetailsViewController;
                mdvc.navigationItem.title = title
                mdvc.posterURL = originalUrl
                mdvc.synopsisString = synopsis!
                
            
        }
    }

}
