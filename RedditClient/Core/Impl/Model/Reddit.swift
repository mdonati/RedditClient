//
//  Reddit.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

private enum ThumbnailInvalidTypes : String {
    case selfPost = "self"
    case nsfw = "nsfw"
}

struct Reddit : RedditProtocol, MappableProtocol {
    
    var title : String
    var author : String
    var thumbnailImageURL : URL?
    var fullSizeImageURL : URL?
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
        
        if let thumbURLString = data["thumbnail"] as? String, self.isThumbnailValid(thumbURL: thumbURLString) {
            self.thumbnailImageURL = URL(string: thumbURLString)
        }
        
        //Try to get full-size image URL
        if let preview = data["preview"] as? [String : Any],
            let images = preview["images"] as? [[String : Any]],
            let mainImage = images.first?["source"] as? [String : Any],
            let mainImageURLString = mainImage["url"] as? String {
            self.fullSizeImageURL = URL(string: mainImageURLString)
        }
    }
    
    private func isThumbnailValid(thumbURL : String) -> Bool {
        return ThumbnailInvalidTypes(rawValue: thumbURL) == nil
    }
    
}
