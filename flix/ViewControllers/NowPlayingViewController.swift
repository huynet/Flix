//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Huy Pham on 9/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    
    var refreshControl: UIRefreshControl!
    
    @IBAction func fetchSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            print("ON")
            MovieAPIManager().fetchMovies { (movies, error) in
                if let movies = movies {
                    self.movies = movies
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        } else {
            print("OFF")
            MovieAPIManager().fetchPopularMovies { (movies, error) in
                if let movies = movies {
                    self.movies = movies
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        MovieAPIManager().fetchMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        activityIndicator.startAnimating()
        MovieAPIManager().fetchMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        NSLog("The webview is done loading")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
