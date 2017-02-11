//
//  Engine.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

fileprivate enum EndPoint : String {
    
    case AccessToken = "access_token"
    
}

class Engine : EngineProtocol, AuthenticatorProtocol {
    
    typealias ListingType = Listing
    
    private let queue : OperationQueue
    var appAuthInfo : AppAuthInfo?
    
    init() {
        self.queue = OperationQueue()
    }
    
    //MARK: -Engine
    
    func fetchTopFeed(limit: Int, after: String?, count: Int?, success: @escaping (ListingType) -> Void, failure: @escaping (Error) -> Void) {
        
    }
    
    //MARK: -Authenticator
    
    func authenticate(success: @escaping (AppAuthInfo) -> Void, failure: (Error) -> Void) {
        
    }
    
    //MARK: -Helpers
    
    private func submitBaseAuthOperation(operation : Operation) {
        let authOperation = self.getCurrentAuthOperation()
        operation.addDependency(authOperation)
        self.queue.addOperation(operation)
    }
    
    private func getCurrentAuthOperation() -> Operation {
        for operation in self.queue.operations {
            if operation.isKind(of: AppAuthOperation.self) {
                return operation
            }
        }
        let authOperation = AppAuthOperation(authenticator : self)
        self.queue.addOperation(authOperation)
        return authOperation
    }
    
}
