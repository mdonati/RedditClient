//
//  AppAuthOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

class AppAuthOperation : BaseOperation {
    
    private var authenticator : AuthenticatorProtocol
    
    init(authenticator : AuthenticatorProtocol) {
        self.authenticator = authenticator
    }
    
    override func main() {
        
        if let currentAuthInfo = self.authenticator.appAuthInfo, Date() < currentAuthInfo.expiresIn {
            self.finish()
            return
        }
        
        self.authenticator.authenticate(success: { (authInfo) in
            self.authenticator.appAuthInfo = authInfo
            self.finish()
        }) { (error) in
            self.finish()
        }
        
    }
    
}
