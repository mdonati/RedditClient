//
//  ImageCacheProtocol.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    
    init()
    func getImage(key : String) -> UIImage?
    func setImage(image : UIImage, forKey key : String)
    
}
