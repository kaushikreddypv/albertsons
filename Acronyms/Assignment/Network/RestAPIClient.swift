//  RestAPIClient.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Foundation
import Alamofire

/// This class is an interface to call the rest API.

class RestAPIClient {
    
    /// Generic method to make the API request and decode the data to generic type.
    private static func request<T: Codable>(type: T.Type,
                                            route: APIRouter,
                                            completion:@escaping (Result < T,
                                                                           APIError>)
                                                -> Void) {
        
        AF.request(route).response { response in
            let result = response.result
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.runtimeError("No Proper data recieved")))
                    return
                }
                
                guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.runtimeError("No Proper data recieved")))
                    return
                }
                completion(.success(obj))
            case .failure(let error):
                completion(.failure(.runtimeError(error.localizedDescription)))
            }
        }
        
    }
    
    
    static func getAcromine(text: String, completion:@escaping (Result<[ContentModel], APIError>) -> Void) {
        return request(type: [ContentModel].self, route: APIRouter.getAcromine(text: text),
                       completion: completion)
        
    }
    
    
    
    
}
