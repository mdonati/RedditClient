//
//  Engine.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

enum EndPoint : String {
    
    case AccessToken = "api/v1/access_token"
    case TopFeed = "top.json"
    
}

class Engine : EngineProtocol {
    
    private let queue : OperationQueue
    var appAuthInfo : AppAuthInfo?
    
    init() {
        self.queue = OperationQueue()
    }
    
    //MARK: -Engine
    
    func fetchTopFeed(limit: Int, after: String?, count: Int?, success: @escaping (ListingProtocol) -> Void, failure: @escaping (Error) -> Void) {
        let topFeedOperation = TopFeedOperation(type: "day")
        topFeedOperation.success = success
        topFeedOperation.failure = failure
        self.submitOperation(operation: topFeedOperation)
    }
    
    //MARK: -Helpers
    
    private func submitOperation<T>(operation : RedditRequestOperation<T>) {
        if self.appAuthInfo == nil || Date() > self.appAuthInfo!.expiresIn {
            let authOperation = self.getCurrentAuthOperation()
            operation.addDependency(authOperation)
        }
        operation.engine = self
        self.queue.addOperation(operation)
    }
    
    private func getCurrentAuthOperation() -> Operation {
        for operation in self.queue.operations {
            if operation.isKind(of: AppAuthOperation.self) {
                return operation
            }
        }
        let authOperation = AppAuthOperation()
        
        authOperation.success = { (authInfo) -> Void in
            self.appAuthInfo = authInfo
        }
        
        authOperation.failure = { (error) -> Void in
            print("App authorization failed: \(error)")
        }
        
        self.queue.addOperation(authOperation)
        return authOperation
    }
    
}
