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
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            
            webView.load(request)
            
        }
        
        // load it in the website
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
