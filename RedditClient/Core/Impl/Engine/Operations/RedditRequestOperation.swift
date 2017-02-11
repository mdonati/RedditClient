//
//  RedditRequestOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

enum AuthType {
    
    case None
    case Basic
    case App
    
}

fileprivate let baseURL = "https://www.reddit.com/"

class RedditRequestOperation<ResponseType : MappableProtocol> : RequestOperation<JSONResponseSerializer> {
    
    var engine : EngineProtocol!
    
    var success : ((_ response : ResponseType) -> Void)?
    var failure : ((_ error : Error) -> Void)?
    
    var authType : AuthType = .App
    
    init(httpMethod : HTTPMethod, endPoint : EndPoint) {
        super.init(httpMethod: httpMethod, url: URL(string: baseURL.appending(endPoint.rawValue))!)
    }
    
    override func main() {
        switch self.authType {
        case .Basic:
            self.setBasicAuth()
        case .App:
            self.setAppAuth()
        default:
            break
        }
        super.main()
    }
    
    override func handleResult(result: [String : Any]) {
        if let parsedResult = ResponseType(dictionary: result) {
            self.success?(parsedResult)
        } else {
            self.handleErrorFromResult(result: result)
        }
    }
    
    func handleErrorFromResult(result : [String : Any]) {
        //TODO: handle error coming from API here
        let error = NSError(domain: "dev.reddit", code: 1000, userInfo: nil)
        self.failure?(error)
    }
    
    final override func handleFailure(response: URLResponse?, error: Error?) {
        var errorToFailWith : Error! = error
        if errorToFailWith == nil {
            errorToFailWith = super.createCustomError(requestError: UnknownError, underlyingError: nil)
        }
        self.failure?(errorToFailWith)
    }
    
    private func setBasicAuth() {
        let userPasswordString = "7a9EaA3EFbjpEA:nopassword"
        let userPasswordData = userPasswordString.data(using: .utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        self.headers["Authorization"] = authString
    }
    
    private func setAppAuth() {
        self.headers["Authorization"] = "Bearer \(self.engine.appAuthInfo!.accessToken)"
    }
    
}
