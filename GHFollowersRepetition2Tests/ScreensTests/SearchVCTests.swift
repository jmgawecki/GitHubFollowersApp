//
//  SearchVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class SearchVCTests: XCTestCase {

    func testSearchVCImageShowsGHLogo() {
        // Arrange
        let sut         = SearchVC()
        let imageToLoad = UIImage(named: "gh-logo")
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertEqual(sut.logoImage.image, imageToLoad)
    
    }
    
    
    func testIsUsernameEnteredShouldReturnTrue() {
        // Arrange
        let sut = SearchVC()
        
        
        // Act
        sut.loadViewIfNeeded()
        sut.usernameTextField.text = "There is a text"
        
        
        // Assert
        XCTAssertEqual(sut.isUsernameEntered, true)
    }
    
    
    func testIsUsernameEnteredShouldReturnFalse() {
        // Arrange
        let sut = SearchVC()
        
        
        // Act
        sut.loadViewIfNeeded()
        sut.usernameTextField.text = ""
        
        
        // Assert
        XCTAssertEqual(sut.isUsernameEntered, false)
    }

}
