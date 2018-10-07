//
//  Movie.swift
//  flix
//
//  Created by Huy Pham on 10/7/18.
//  Copyright © 2018 codepath. All rights reserved.
//

import Foundation

class Movie {
    // MARK: Add Properties
    var title: String?
    var overview: String?
    var posterUrl: URL?
    var backdropUrl: URL?
    var release_date: String?
    
    // MARK: Add initializers
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No Title"
        overview = dictionary["overview"] as? String ?? "No Overview"
        release_date = dictionary["release_date"] as! String
        
        let baseURLString = "https://image.tmdb.org/t/p/w500";
        
        let posterPathString = dictionary["poster_path"] as! String;
        posterUrl = URL(string: baseURLString + posterPathString);

        let backDropString = dictionary["backdrop_path"] as! String
        backdropUrl = URL(string: baseURLString + backDropString)!;
    }
    
    class func getMovies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
