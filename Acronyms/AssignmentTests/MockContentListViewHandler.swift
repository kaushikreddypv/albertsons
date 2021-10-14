//
//  MockContentListViewHandler.swift
//  AssignmentTests
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Foundation
@testable import Assignment

class MockContentListViewHandler: ContentListViewHandlerProtocol {
    func getAcromine(text: String, completion: @escaping (Result<[ContentModel], APIError>) -> Void) {
        guard let jsonData = readLocalJson(forName: "ContentListResponse")  else {
            completion(.failure(.runtimeError("No Data Found")))
            return
        }
        do {
            let decodedData = try JSONDecoder().decode([ContentModel].self, from: jsonData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.runtimeError("No Data Found")))

        }
       
    }

    
    func readLocalJson(forName name: String) -> Data? {
        do {
            guard let fileUrl = Bundle.main.url(forResource: name, withExtension: "json") else { return nil }
            let data = try Data(contentsOf: fileUrl)
            return data
            
        } catch {
            print("error: \(error)")
            return nil

        }
    }
    
    
    
}
