//
//  Listing.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

struct Listing<ListingChildrenType : MappableProtocol> : ListingProtocol, MappableProtocol {
    
    typealias ChildrenType = ListingChildrenType
    
    var after : String?
    var before : String?
    var show : String?
    var children: [ListingChildrenType]
    
    init?(dictionary: [String : Any]) {
        
        guard let data = dictionary["data"] as? [String : Any] else {
            return nil
        }
        
        self.after = data["after"] as? String
        self.before = data["before"] as? String
        self.show = data["show"] as? String
        
        var children = [ListingChildrenType]()
        if let childrenDicts = data["children"] as? [[String : Any]] {
            for childrenDict in childrenDicts {
                if let child = ListingChildrenType(dictionary: childrenDict) {
                    children.append(child)
                }
            }
        }
        self.children = children
        
    }
    
}
