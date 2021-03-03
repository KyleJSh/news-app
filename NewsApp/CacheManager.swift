//
//  CacheManager.swift
//  NewsApp
//
//  Created by Kyle Sherrington on 2021-03-02.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data) {
        
        // Save the image data along with the url
        imageDictionary[url] = imageData
        
    }
    
    static func retrieveData(_ url:String) -> Data? {
        
        // return the saved image data or nil
        return imageDictionary[url]
        
    }
    
}
