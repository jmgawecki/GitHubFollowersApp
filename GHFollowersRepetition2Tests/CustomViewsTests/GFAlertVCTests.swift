//
//  GFAlertVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class GFAlertVCTests: XCTestCase {

    func testGFAlerVCExists() {
        // Arrange
        let sut = GFAlertVC(alertTitle: "TitleTest", message: "MessageTest", buttonLabel: "ButtonTest")
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
}
