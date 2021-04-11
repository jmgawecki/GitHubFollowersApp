//
//  FollowerCellTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class CellTests: XCTestCase {

    func testFollowerCellExists() {
        // Arrange
        let sut = FollowerCell()
        
        
        // Act
        sut.reloadInputViews()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testFollowerCellImageHasPlaceHolder() {
        // Arrange
        let sut = FollowerCell()
        let follower = Follower(login: "jmgawecki", avatarUrl: "")
        
        
        // Act
        sut.reloadInputViews()
        sut.set(on: follower)
        
        
        // Assert
        XCTAssertNotNil(sut.avatarImageView.image)
    }
    
    
    func testFavoriteCellExists() {
        // Arrange
        let sut = FavoriteCell()
        
        
        // Act
        sut.reloadInputViews()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
}
