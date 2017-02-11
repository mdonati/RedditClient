//
//  JSONResponseSerializer.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class JSONResponseSerializer : ResponseSerializerProtocol {
    
    typealias ResponseType = [String : Any]
    
    required init() {
        
    }
    
    func deserialize(data: Data?) -> Dictionary<String, Any>? {
        guard let data = data else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
    }
    
}
