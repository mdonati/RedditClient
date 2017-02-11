//
//  Listing.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

struct Listing : ListingProtocol, MappableProtocol {
    
    var after : String?
    var before : String?
    var count: Int
    var limit : Int
    var show : String?
    
    init?(dictionary: [String : Any]) {
        
        guard let count = dictionary["count"] as? Int, let limit = dictionary["limit"] as? Int else {
            return nil
        }
        
        self.after = dictionary["after"] as? String
        self.before = dictionary["before"] as? String
        self.show = dictionary["show"] as? String
        self.limit = limit
        self.count = count
        
    }
    
}
