//
//  TopFeedOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class TopFeedOperation : RedditRequestOperation<Listing<Reddit>> {
    
    init(timeLimit : TimeLimit, limit : Int, after : String?, count : Int?) {
        super.init(httpMethod: .GET, endPoint: .TopFeed)
        self.parameters["t"] = timeLimit.rawValue
        self.parameters["limit"] = limit
        if let after = after {
            self.parameters["after"] = after
        }
        
        if let count = count {
            self.parameters["count"] = count
        }
    }
    
}
