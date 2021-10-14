//
//  ContentListViewModelTests.swift
//  AssignmentTests
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import XCTest
import Combine
@testable import Assignment

class ContentListViewModelTests: XCTestCase {
    
    func testContentList() {
        let vc = ContentListViewModel(handlerService: MockContentListViewHandler())
        vc.getAcromine(text: "Wwe")
        XCTAssert(vc.lfsCount == 2)
        
    }

}
