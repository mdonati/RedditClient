//
//  AuthenticatorProtocol.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

struct AppAuthInfo : MappableProtocol {
    
    var accessToken : String
    var expiresIn : Date
    var tokenType : String
    var scope : String
    
    init?(dictionary : [String : AnyObject]) {
        guard let accessToken = dictionary["accessToken"] as? String,
              let expiresIn = dictionary["expires_in"] as? TimeInterval,
              let tokenType = dictionary["token_type"] as? String,
              let scope = dictionary["scope"] as? String else {
              return nil
        }
        
        self.accessToken = accessToken
        self.expiresIn = Date(timeIntervalSince1970: expiresIn)
        self.tokenType = tokenType
        self.scope = scope
    }
    
}

protocol AuthenticatorProtocol {
    
    var appAuthInfo : AppAuthInfo? { get set }
    
    func authenticate(success : @escaping (_ authInfo : AppAuthInfo) -> Void, failure : (_ error : Error) -> Void)
    
}
