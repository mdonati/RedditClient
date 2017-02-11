//
//  ListingProtocol.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

protocol ListingProtocol {
    
    var after : String? { get }
    var before : String? { get }
    var limit : Int { get }
    var count : Int { get }
    var show : String? { get }
    
}
