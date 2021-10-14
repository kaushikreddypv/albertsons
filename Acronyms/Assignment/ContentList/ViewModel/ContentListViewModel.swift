//
//  ContentListViewModel.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Foundation
import Combine


/// This class handles the view logic for `ContentListViewController`
class ContentListViewModel {
    private let handlerService: ContentListViewHandlerProtocol
    var updateViewSubject = PassthroughSubject<Void,Never>()
    
    private var contents = [ContentModel]() {
        didSet {
            lfs = contents.first?.lfs ?? [LF]()
        }
    }
    private var lfs = [LF]()

    
    init(handlerService: ContentListViewHandlerProtocol = ContentListViewHandler() ) {
        self.handlerService =  handlerService
    }
    
    /// total items count
    var lfsCount: Int {
        return lfs.count
    }
    
    
   
    
    /// item at particular index
    func lfs(atIndex index: Int) -> LF? {
        return lfs[index]
    }
    
    
    /// calls the handler to get the  comments.
    func getAcromine(text: String) {
        handlerService.getAcromine(text: text) {[weak self] result in
            switch result {
            case .success(let model):
                self?.contents = model
            case .failure(let error):
                switch error {
                case .runtimeError(let message):
                    print("Error occured \(message)")
                }
            }
            self?.updateViewSubject.send()
        }
    }
    
    
}
