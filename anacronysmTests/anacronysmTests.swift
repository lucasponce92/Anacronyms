//
//  anacronysmTests.swift
//  anacronysmTests
//
//  Created by Lucas Ponce on 06-11-21.
//

import XCTest
@testable import anacronyms

class anacronysmTests: XCTestCase {
    
    var lfCardVM = LFCardVM()

    func testNumberOfVariantsString() {
        
        let vars = [LongForm(),LongForm()]
        let string = "Tap to see 2 more variants"
        
        XCTAssertEqual(string, lfCardVM.getButtonTitle(vars: vars))
    }
    
    func testEmptyVariantsString(){
        
        let vars = [LongForm]()
        let string = "There are no other variants to show"
        
        XCTAssertEqual(string, lfCardVM.getButtonTitle(vars: vars))
    }
}
