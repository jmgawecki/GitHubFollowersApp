//
//  FavoritesVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class FavoritesVCTests: XCTestCase {

    func testFavoritesVCExists() {
        // Arrange
        let sut = FavoritesVC()
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }

    
    func testFavoritesVCWillAppear() {
        // Arrange
        let sut = FavoritesVC()
        
        
        // Act
        sut.loadViewIfNeeded()
        sut.viewWillAppear(true)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
}
