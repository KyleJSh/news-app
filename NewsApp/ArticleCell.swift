//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Kyle Sherrington on 2021-03-02.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        // clean up cell before displaying next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        
        // Download and display the image
        
        // Check that the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // create the url string
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the cache manager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // There is image data, set the imageview and return
            articleImageView.image = UIImage(data: imageData)
            
            // set animation for displaying images
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            
            return
            
        }
        
        // create the url
        let url = URL(string: urlString)
        
        // check that the url isn't nil
        guard url != nil else {
            print("couldn't create url object")
            return
        }
        
        // get a URLSession
        let session = URLSession.shared
        
        // create a dataTask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check that there were no errors
            
            if error == nil && data != nil {
                
                // Save the data into cache
                CacheManager.saveData(urlString, data!)
                
                // check if the url string that the data task went off to downoad matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    
                    DispatchQueue.main.async {
                        
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                        
                    }
                } // end if
                
            } // end if
            
        } // end data task
        
        // Kick off the dataTask
        dataTask.resume()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
