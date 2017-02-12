//
//  NSCacheImageCache.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit

class NSCacheImageCache : ImageCacheProtocol {
    
    private let cache = NSCache<NSString, UIImage>()
    
    required init() {
        
    }
    
    func getImage(key: String) -> UIImage? {
        return self.cache.object(forKey: NSString(string: key))
    }
    
    func setImage(image: UIImage, forKey key: String) {
        self.cache.setObject(image, forKey: NSString(string : key))
    }
    
}
