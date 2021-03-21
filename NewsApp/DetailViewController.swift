//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Kyle Sherrington on 2021-03-01.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check that there's a url
        if articleUrl != nil {
            
            
            // create the url bject
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                // couldn't create url object
                return
            }
            
            // create the URLRequest object
            let request = URLRequest(url: url!)
            
            // Start spinner, make sure it's back to alpha = 1
            spinner.alpha = 1
            spinner.startAnimating()
            
            webView.load(request)
        }
        
        // load it in the website
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    // this needs to be manually added, Xcode won't warn you
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
        
    }
}
