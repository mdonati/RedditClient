//
//  Reddit.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

protocol RedditProtocol {
    
    var title : String { get }
    var author : String { get }
    var thumbnailImageURL : URL? { get }
    var fullSizeImageURL : URL? { get }
    var date : Date { get }
    var commentsCount : Int { get }
    
}
