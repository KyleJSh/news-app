//
//  Article.swift
//  NewsApp
//
//  Created by Kyle Sherrington on 2021-03-01.
//

import Foundation

struct Article: Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var PublishedAt:String?
    
}
