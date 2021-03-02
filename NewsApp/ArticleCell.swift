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
        headlineLabel.text = ""
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Download and display the image
        
        // Check that the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // create the url string
        let urlString = articleToDisplay!.urlToImage!
        
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
                
                // check if the url string that the data task went off to downoad matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    
                    DispatchQueue.main.async {
                        
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
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
