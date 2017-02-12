//
//  RedditEngineProtocol.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

enum TimeLimit : String {
    
    case Hour = "hour"
    case Day = "day"
    case Week = "week"
    case Month = "month"
    case Year = "year"
    case All = "all"
    
}

protocol EngineProtocol {
    
    init()
    
    var appAuthInfo : AppAuthInfo? { get }
    
    func fetchTopFeed(timeLimit : TimeLimit, limit : Int, after : String?, count : Int?, success : @escaping (_ results : ListingProtocol) -> Void, failure : @escaping (_ error : Error) -> Void)
    
}
