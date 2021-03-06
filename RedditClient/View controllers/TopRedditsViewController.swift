//
//  TopRedditsViewController.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class TopRedditsViewController : RedditListingViewController {
    
    override func fetchReddits(timeLimit: TimeLimit, limit: Int, after: String?, count: Int?, success: @escaping (ListingProtocol) -> Void, failure: @escaping (Error) -> Void) {
        AppRoot.engine.fetchTopFeed(timeLimit: timeLimit, limit: limit, after: after, count: count, success: success, failure: failure)
    }
    
}
