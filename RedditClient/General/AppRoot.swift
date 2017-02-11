//
//  AppRoot.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

let appRoot = AppRoot<NSURLSessionEngine>()

class AppRoot<EngineType : EngineProtocol> {
    
    let engine : EngineType = EngineType()
    
    init() {
        
    }
    
}
