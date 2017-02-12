//
//  Listing.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

struct Listing<RedditType : RedditProtocol> : ListingProtocol, MappableProtocol where RedditType : MappableProtocol {
    
    var after : String?
    var before : String?
    var show : String?
    var children: [RedditProtocol]
    
    init?(dictionary: [String : Any]) {
        
        guard let data = dictionary["data"] as? [String : Any] else {
            return nil
        }
        
        self.after = data["after"] as? String
        self.before = data["before"] as? String
        self.show = data["show"] as? String
        
        var children = [RedditProtocol]()
        if let childrenDicts = data["children"] as? [[String : Any]] {
            for childrenDict in childrenDicts {
                if let child = RedditType(dictionary: childrenDict) {
                    children.append(child)
                }
            }
        }
        self.children = children
        
    }
    
}
