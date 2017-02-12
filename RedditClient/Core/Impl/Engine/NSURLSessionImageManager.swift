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
    private let session : URLSession
    
    required init(imageCache: ImageCacheProtocol) {
        self.imageCache = imageCache
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?, URL) -> Void) {
        if let cachedImage = self.imageCache.getImage(key: self.keyForURL(url: url)) {
            completion(cachedImage, url)
        } else {
            let dataTask = self.session.dataTask(with: url, completionHandler: { (data, response, error) in
                var image : UIImage?
                if let data = data, error == nil {
                    image = UIImage(data: data)
                    if let image = image {
                        self.imageCache.setImage(image: image, forKey: self.keyForURL(url: url))
                    }
                }
                DispatchQueue.main.async {
                    completion(image, url)
                }
            })
            dataTask.resume()
        }
    }
    
    private func keyForURL(url : URL) -> String {
        return url.absoluteString
    }
    
}
