//
//  ViewController.swift
//  NewsApp
//
//  Created by Kyle Sherrington on 2021-03-01.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the articles from the model
        model.delegate = self
        model.getArticles()
        
    }
    
}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    
    func articlesRetrieved(_ articles: [Article]) {
        
        self.articles = articles
        
    }
    
}
