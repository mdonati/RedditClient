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
        return nil
    }
    
    func setImage(image: UIImage, forKey key: String) {
        
    }
    
}
