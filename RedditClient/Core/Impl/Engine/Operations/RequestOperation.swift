//
//  RequestOperation.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

typealias RequestError = (code : Int, message : String)

let UnknownError = RequestError(code: -10, message: "Response failed, but somehow we got no error :(")
let UnexpectedResponseType = RequestError(code: -11, message : "Loaded a response that is not a HTTP URL response")
let UnprocessableResponse = RequestError(code: -12, message : "Data is null or is not in the expected format")
let UnauthorizedRequestError = RequestError(code: -13, message : "Received 401 http status code")

enum HTTPMethod : String {
    
    case GET = "GET"
    case POST = "POST"
    
}

class RequestOperation<ResponseSerializerType : ResponseSerializerProtocol> : BaseOperation {
    
    let httpMethod : HTTPMethod
    let url : URL
    var parameters : [String : Any] = [:]
    var headers : [String : String] = [:]
    
    init(httpMethod : HTTPMethod, url : URL) {
        self.httpMethod = httpMethod
        self.url = url
    }
    
    override func main() {
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        var finalURL = self.url
        
        if self.httpMethod == .GET && self.parameters.count > 0 {
            finalURL = URL(string: self.url.absoluteString.appending("?\(self.percentEncodedStringFromHttpParameters())"))!
        }
        
        let request = NSMutableURLRequest(url: finalURL)
        
        //HTTP method
        request.httpMethod = self.httpMethod.rawValue
        
        //HTTP headers
        for (key, value) in self.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if self.httpMethod == .POST && self.parameters.count > 0 {
            request.httpBody = self.stringFromHTTPParameters().data(using: .utf8)
        }
        
        print("Executing request to url: \(finalURL)")
        
        //Create the data task and handle the response on its completion handler
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200, 201:
                    if let result = ResponseSerializerType().deserialize(data: data) {
                        self.handleResult(result: result)
                    } else {
                        self.handleFailure(response: response, error: self.createCustomError(requestError: UnprocessableResponse, underlyingError: error))
                    }
                case 401, 403:
                    self.handleFailure(response: response, error: self.createCustomError(requestError: UnauthorizedRequestError, underlyingError: error))
                default:
                    self.handleFailure(response : response, error: error)
                }
            } else {
                self.handleFailure(response: response, error: self.createCustomError(requestError: UnexpectedResponseType, underlyingError: error))
            }
            
            self.finish()
            
        }
        
        //Start the task
        task.resume()
        
    }
    
    func handleResult(result : ResponseSerializerType.ResponseType) {
        assertionFailure("To be implemented in child classes")
    }
    
    func handleFailure(response : URLResponse?, error : Error?) {
        assertionFailure("To be implemented in child classes")
    }
    
    func createCustomError(requestError : RequestError, underlyingError : Error?) -> NSError
    {
        var userInfo = [AnyHashable : Any]()
        if let underlyingError = underlyingError {
            userInfo["underlayingError"] = underlyingError
        }
        userInfo["message"] = requestError.message
        return NSError(domain: "dev.request", code: requestError.code, userInfo: userInfo)
    }
    
    //MARK: -Helpers
    
    private func percentEncodedStringFromHttpParameters() -> String {
        let parameterArray = self.parameters.map { (key, value) -> String in
            let percentEscapedKey = self.percentEncodedString(string: key)
            let percentEscapedValue = self.percentEncodedString(string: value as! String)
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
    
    private func stringFromHTTPParameters() -> String {
        let parameterArray = self.parameters.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        return parameterArray.joined(separator: "&")
    }
    
    private func percentEncodedString(string : String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
    }
    
}
