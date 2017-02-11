//
//  RedditEntryProtocol.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

protocol EntryProtocol {
 
    var title : String { get }
    var author : String { get }
    var description : String { get }
    var thumbnailImageURL : String { get }
    var fullSizeImageURL : String { get }
    var date : Date { get }
    var commentsCount : Int { get }
    
}
