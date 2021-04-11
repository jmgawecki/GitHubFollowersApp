//
//  UserInfoVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//


import XCTest
@testable import GHFollowersRepetition2
// Fix!!!
class UserInfoVCTests: XCTestCase {
    // Fix!!!
    func testUserInfoVCExists() {
        // Arrange
        let sut     = UserInfoVC()
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
        sut.username = "jmgawecki"
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    func testGetUserInfoFunction() {
        // Arrange
        let sut = UserInfoVC()
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
        sut.username = "jmgawecki"
        
        // Act
        sut.getUserInfo()
        
        // Assert
        XCTAssertNotNil(sut)
    }
}
