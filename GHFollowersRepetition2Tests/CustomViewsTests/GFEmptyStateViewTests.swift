//
//  GFEmptyStateViewTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class GFEmptyStateViewTests: XCTestCase {

    func testGFEmptyStateViewExists() {
        // Arrange
        let sut = GFEmptyStateView(message: "MessageTest")
        
        
        // Act
        sut.reloadInputViews()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFEmptyStateViewExistsWithNoMessagePassed() {
        // Arrange
        let sut = GFEmptyStateView()
        
        
        // Act
        sut.reloadInputViews()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }

}
