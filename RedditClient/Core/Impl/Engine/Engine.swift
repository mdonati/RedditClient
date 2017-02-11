//
//  Engine.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

enum EndPoint : String {
    
    case AccessToken = "access_token"
    
}

class Engine : EngineProtocol {
    
    private let queue : OperationQueue
    var appAuthInfo : AppAuthInfo?
    
    init() {
        self.queue = OperationQueue()
    }
    
    //MARK: -Engine
    
    func fetchTopFeed(limit: Int, after: String?, count: Int?, success: @escaping (ListingProtocol) -> Void, failure: @escaping (Error) -> Void) {
        self.submitOperation(operation: BlockOperation(block: { 
            print("OK")
        }))
    }
    
    //MARK: -Helpers
    
    private func submitOperation(operation : Operation) {
        if self.appAuthInfo == nil || Date() > self.appAuthInfo!.expiresIn {
            let authOperation = self.getCurrentAuthOperation()
            operation.addDependency(authOperation)
        }
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
