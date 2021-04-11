//
//  GFUserInfoHeaderVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class GFUserInfoHeaderVCTests: XCTestCase {

    
    func testGFUserInfoHeaderVCExists() {
        // Arrange
        let user    = User(login:       "jmgawecki",
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
        
        let sut = GFUserInfoHeaderVC(user: user)
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFUserInfoHeaderVCExistsWhenOptionalsAreNil() {
        // Arrange
        let user        = User(login: "TestLogin",
                               avatarUrl: "TestAvatar",
                               name: nil,
                               location: nil,
                               bio: nil,
                               publicRepos: 1,
                               publicGists: 1,
                               htmlUrl: "TestUrl",
                               followers: 1,
                               following: 1,
                               createdAt: "TestDate")
        let sut = GFUserInfoHeaderVC(user: user)
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    

}
