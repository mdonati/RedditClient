//
//  TopFeedOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class TopFeedOperation : RedditRequestOperation<Listing<Reddit>> {
    
    init(timeLimit : TimeLimit) {
        super.init(httpMethod: .GET, endPoint: .TopFeed)
        self.parameters["t"] = timeLimit.rawValue
    }
    
}
