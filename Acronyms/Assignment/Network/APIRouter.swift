//
//  APIRouter.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Alamofire
import Foundation

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

// Custom Error object API Calls.
enum APIError: Error {
    case runtimeError(String)
}

// Request parameter types.
enum RequestParams {
    case body(_:Parameters)
}

enum ContentType: String {
    case json = "application/json"
}

/// Builds the URLRequest object.
enum APIRouter: URLRequestConvertible {
    case getAcromine(text: String)
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case  .getAcromine:
            return .get
        }
    }
    
    // MARK: - url
    private var urlPath: String {
        switch self {
        case let .getAcromine(text: text):
            let url = Constants.domain + "\(text)"
            return url

        }
    }
    
    // MARK: - Parameters
    private var parameters: RequestParams? {
        switch self {
        case  .getAcromine:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try urlPath.asURL()
        var urlRequest = URLRequest(url: url)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        switch self {
        case  .getAcromine:
            var headers = [String: String]()
            headers[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
            urlRequest.allHTTPHeaderFields = headers
        }
        
        // Parameters
        if let parameters = parameters {
            switch parameters {
            case .body(let params):
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        return urlRequest
    }
}
