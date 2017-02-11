//
//  RequestOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

enum HTTPMethod {
    
    case GET
    
}

class RequestOperation : BaseOperation {
    
    let httpMethod : HTTPMethod
    let url : String
    let parameters : [String : AnyObject]?
    
    init(httpMethod : HTTPMethod, url : String, parameters : [String : AnyObject]? = nil) {
        self.httpMethod = httpMethod
        self.url = url
        self.parameters = parameters
    }
    
    override func main() {
        
        
        
    }
    
}
