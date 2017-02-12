//
//  NSURLSessionImageManager.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit

class NSURLSessionImageManager : ImageManagerProtocol {
    
    private let imageCache : ImageCacheProtocol
    
    required init(imageCache: ImageCacheProtocol) {
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
