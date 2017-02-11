//
//  TopFeedOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class TopFeedOperation : RedditRequestOperation<Listing<Reddit>> {
    
    let type : String
    
    init(type : String) {
        self.type = type
        super.init(httpMethod: .GET, endPoint: .TopFeed)
        self.authType = .None
    }
    
}
