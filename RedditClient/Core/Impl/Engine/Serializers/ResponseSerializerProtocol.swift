//
//  ResponseSerializer.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

protocol ResponseSerializerProtocol {
    
    associatedtype ResponseType
    
    init()
    func deserialize(data : Data?) -> ResponseType?
    
}
