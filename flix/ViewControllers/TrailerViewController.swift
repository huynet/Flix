//
//  TrailerViewController.swift
//  flix
//
//  Created by Huy Pham on 9/13/18.
//  Copyright © 2018 codepath. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var movie: [String: Any]?
    
    var temp: String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            let idOptional = movie["id"]
            if let id = idOptional {
                let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                let task = session.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let data = data {
                        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let movies = dataDictionary["results"] as! [[String: Any]]
                        
                        let key = movies[0]["key"] as! String
                        let baseURLString = "https://www.youtube.com/watch?v=\(String(describing: key))"
                        let myURL = URL(string: baseURLString)
                        let myRequest = URLRequest(url: myURL!)
                        self.webView.load(myRequest)
                    }
                }
                task.resume()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
