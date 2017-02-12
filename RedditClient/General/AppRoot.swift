//
//  AppRoot.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

let appRoot = AppRoot<NSURLSessionEngine, NSURLSessionImageManager<NSCacheImageCache>>()

class AppRoot<EngineType : EngineProtocol, ImageManagerType : ImageManagerProtocol> {
    
    let engine : EngineType = EngineType()
    
    let imageManager : ImageManagerType = ImageManagerType(imageCache : ImageManagerType.ImageCacheType())
    
    init() {
        
    }
    
}
