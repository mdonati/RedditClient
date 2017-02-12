//
//  AppRoot.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class AppRoot {
    
    static let engine : EngineProtocol = NSURLSessionEngine()
    
    static let imageManager : ImageManagerProtocol = NSURLSessionImageManager(imageCache : NSCacheImageCache())
    
    //This class isn't meant to be instantiated
    private init() {
        
    }
    
}
