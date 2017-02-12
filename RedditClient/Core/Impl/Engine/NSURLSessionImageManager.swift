//
//  NSURLSessionImageManager.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit

class NSURLSessionImageManager<ImageCacheGenericType : ImageCacheProtocol> : ImageManagerProtocol {
    
    typealias ImageCacheType = ImageCacheGenericType
    
    private var imageCache : ImageCacheType
    
    required init(imageCache: ImageCacheType) {
        self.imageCache = imageCache
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = self.imageCache.getImage(key: self.keyForURL(url: url)) {
            completion(cachedImage)
        } else {
            //TODO: Download image here and cache the result
        }
    }
    
    private func keyForURL(url : URL) -> String {
        return url.absoluteString
    }
    
}
