//
//  Reddit.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

struct Reddit : RedditProtocol, MappableProtocol {
    
    var title : String
    var author : String
    var thumbnailImageURL : String?
    var fullSizeImageURL : String?
    var date : Date
    var commentsCount : Int
    
    init?(dictionary: [String : Any]) {
        guard let data = dictionary["data"] as? [String : Any],
            let author = data["author"] as? String,
            let utcEpoc = data["created_utc"] as? TimeInterval,
            let commentsCount = data["num_comments"] as? Int,
            let title = data["title"] as? String else {
                return nil
        }
        self.author = author
        self.date = Date(timeIntervalSince1970: utcEpoc)
        self.commentsCount = commentsCount
        self.title = title
        self.thumbnailImageURL = data["thumbnail"] as? String
        
        //Try to get full-size image URL
        if let preview = data["preview"] as? [String : Any],
            let images = preview["images"] as? [[String : [String : Any]]],
            let mainImage = images.first?["source"] {
            self.fullSizeImageURL = mainImage["url"] as? String
        }
    }
    
}
