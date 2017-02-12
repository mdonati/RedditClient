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
    
    init(imageCache : ImageCacheProtocol)
    
    func getImage(url : URL, completion : @escaping (_ image : UIImage?) -> Void)
    
}
