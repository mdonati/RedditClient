//
//  Reddit.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

enum Thumbnail {
    case nonImage(type : NonImageThumbnailType)
    case image(url : URL)
}

enum NonImageThumbnailType : String {
    case selfPost = "self"
    case nsfw = "nsfw"
}

protocol RedditProtocol {
    
    var title : String { get }
    var author : String { get }
    var thumbnail : Thumbnail? { get }
    var fullSizeImageURL : URL? { get }
    var date : Date { get }
    var commentsCount : Int { get }
    
}
