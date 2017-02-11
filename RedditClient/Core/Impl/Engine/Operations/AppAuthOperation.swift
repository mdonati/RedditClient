//
//  AppAuthOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class AppAuthOperation : RedditRequestOperation<AppAuthInfo> {
    
    private static let GrantType = "https://oauth.reddit.com/grants/installed_client"
    
    init() {
        super.init(httpMethod: .POST, endPoint: .AccessToken)
        self.authType = .Basic
        self.setParameters()
    }
    
    private override init(httpMethod: HTTPMethod, endPoint: EndPoint) {
        super.init(httpMethod: httpMethod, endPoint: endPoint)
    }
    
    private func setParameters() {
        self.parameters["grant_type"] = AppAuthOperation.GrantType
        self.parameters["device_id"] = UUID().uuidString
    }
    
}
