//
//  FollowersCollectionHeaderViewTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class FollowersCollectionHeaderViewTests: XCTestCase {

    func testFollowersCollectionHeaderViewExists() {
        // Arrange
        let sut = FollowersCollectionHeaderView()
        
        
        // Act
        sut.reloadInputViews()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testFollowersCollecitonHeaderViewExists() {
        // Arrange
        let sut = FollowersCollectionHeaderView()
        sut.user    = User(login:       "jmgawecki",
                           avatarUrl:   "",
                           name:        "Jakub",
                           location:    "Warsaw",
                           bio:         "Bio",
                           publicRepos: 19,
                           publicGists: 10,
                           htmlUrl:     "",
                           followers:   10,
                           following:   10,
                           createdAt:   "Test")
        
        // Act
        sut.reloadInputViews()
        sut.set(with: sut.user)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testFollowerCollectionHeaderViewExistsWhenUserOptionalsAreNil() {
        // Arrange
        let sut  = FollowersCollectionHeaderView()
        sut.user = User(login:          "Jakub",
                        avatarUrl:      "Test",
                        name:           nil,
                        location:       nil,
                        bio:            nil,
                        publicRepos:    1,
                        publicGists:    1,
                        htmlUrl:        "test",
                        followers:      1,
                        following:      1,
                        createdAt:      "test")
        
        
        // Act
        sut.reloadInputViews()
        sut.set(with: sut.user)
        
        
        // Assert
        XCTAssertNotNil(sut)
    }

}
