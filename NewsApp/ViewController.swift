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
        
        // set the view controller as the data source & delegate of the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // get the articles from the model
        model.delegate = self
        model.getArticles()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // detech index path user has selected
        
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            // the user hasn't selected anything
            return
        }
        
        // get the article the user tapped on
        let article = articles[indexPath!.row]
        
        // get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // pass the article url to the detail view controller
        detailVC.articleUrl = article.url!
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // get the article that the tableView is asking about
        let article = articles[indexPath.row]
        
        // TODO: customize it
        cell.displayArticle(article)
        
        
        // return the cell
        return cell
        
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            // user has just selected a row, trigger the segue to go to detail
            performSegue(withIdentifier: "goToDetail", sender: self)
            
        }
    
}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    
    func articlesRetrieved(_ articles: [Article]) {
        
        self.articles = articles
        
        // refresh the table view
        tableView.reloadData()
    }
}
