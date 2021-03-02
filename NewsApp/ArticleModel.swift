//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Kyle Sherrington on 2021-03-01.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved(_ articles:[Article])
    
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        // fire off the request to the API
        
        // create a string URL
        let stringURL = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=738171768cd641cd9e57d6612abe6a5f"
        
        // create a url object
        
        let url = URL(string: stringURL)
        
        // check that it isn't nil
        guard url != nil else {
            print("Couldn't create URL object")
            return
        }
        
        // get the url session
        let session = URLSession.shared
        
        // create data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check that there are no errors and that there is data
            if error == nil && data != nil {
                
                // attempt to parse JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    // parse the json into articleService
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // get the articles
                    let articles = articleService.articles!
                    
                    // pass it back to the view controller in the main thread (not background thread)
                    DispatchQueue.main.async {
                        
                        self.delegate?.articlesRetrieved(articles)
                        
                    }
                    
                }
                catch {
                    print("Error parsing JSON")
                } // End Do - Catch
                
            } // End if
            
        } // end Data Task
        
        // start the data task, call resume method
        dataTask.resume()
        
    }
}
