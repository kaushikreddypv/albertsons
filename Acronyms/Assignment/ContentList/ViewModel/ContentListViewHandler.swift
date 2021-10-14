//
//  ContentListViewHandler.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Foundation


protocol ContentListViewHandlerProtocol {
    func getAcromine(text:String, completion:@escaping (Result<[ContentModel], APIError>) -> Void)
}

/// Concrete class to call the  list API.
class ContentListViewHandler: ContentListViewHandlerProtocol {
    func getAcromine(text: String, completion: @escaping (Result<[ContentModel], APIError>) -> Void) {
        RestAPIClient.getAcromine(text: text, completion: completion)
    }
        
  
}
