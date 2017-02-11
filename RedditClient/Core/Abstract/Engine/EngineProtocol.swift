//
//  RedditEngineProtocol.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    
    associatedtype ListingType : ListingProtocol
    
    func fetchTopFeed(limit : Int, after : String?, count : Int?, success : @escaping (_ results : ListingType) -> Void, failure : @escaping (_ error : Error) -> Void)
    
}
