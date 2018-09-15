//
//  SimilarViewController.swift
//  flix
//
//  Created by Huy Pham on 9/12/18.
//  Copyright © 2018 codepath. All rights reserved.
//

import UIKit
import AlamofireImage

enum SimilarMovieKeys {
    static let title = "title"
    static let release_date = "release_date"
    static let overview = "overview"
    static let backdrop_path = "backdrop_path"
    static let poster_path = "poster_path"
}

class SimilarViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    @IBOutlet weak var buttonLabel: UIButton!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie[SimilarMovieKeys.title] as? String
            releaseDateLabel.text = movie[SimilarMovieKeys.release_date] as? String
            overviewTextView.text = movie[SimilarMovieKeys.overview] as? String
            
            let backdropPathString = movie[SimilarMovieKeys.backdrop_path] as! String
            let posterPathString = movie[SimilarMovieKeys.poster_path] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterURL)
            self.movie = movie
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
