//
//  RedditRequestOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

fileprivate let baseURL = "https://www.reddit.com/api/v1/"

class RedditRequestOperation<ResponseType : MappableProtocol> : RequestOperation<JSONResponseSerializer> {
    
    var success : ((_ response : ResponseType) -> Void)?
    var failure : ((_ error : Error) -> Void)?
    
    init(httpMethod : HTTPMethod, endPoint : EndPoint) {
        super.init(httpMethod: httpMethod, url: URL(string: baseURL.appending(endPoint.rawValue))!)
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
    
}
