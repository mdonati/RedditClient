//
//  ImagesManager.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit

protocol ImageManagerProtocol {
    
    associatedtype ImageCacheType : ImageCacheProtocol
    
    init(imageCache : ImageCacheType)
    
    func getImage(url : URL, completion : @escaping (_ image : UIImage?) -> Void)
    
}
