//
//  GFItemInfoViewTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class GFItemInfoViewTests: XCTestCase {

    func testGFItemInfoViewExists() {
        // Arrange
        let sut = GFItemInfoView()
        
        
        // Act
        sut.reloadInputViews()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFItemInforViewSetWithForFollowersExists() {
        // Arrange
        let sut = GFItemInfoView()
        
        
        // Act
        sut.reloadInputViews()
        sut.set(itemInfoType: .followers, with: 1)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFItemInforViewSetWithForFollowingExists() {
        // Arrange
        let sut = GFItemInfoView()
        
        
        // Act
        sut.reloadInputViews()
        sut.set(itemInfoType: .following, with: 1)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFItemInforViewSetWithForGistsExists() {
        // Arrange
        let sut = GFItemInfoView()
        
        
        // Act
        sut.reloadInputViews()
        sut.set(itemInfoType: .gists, with: 1)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFItemInforViewSetWithForReposExists() {
        // Arrange
        let sut = GFItemInfoView()
        
        
        // Act
        sut.reloadInputViews()
        sut.set(itemInfoType: .repos, with: 1)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }

}
