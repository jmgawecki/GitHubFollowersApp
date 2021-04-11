//
//  GFItemInfoVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class GFItemInfoVCTests: XCTestCase {

    
    func testGFItemInfoVCExists() {
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
        
        let follower = Follower(login: "jgmawecki", avatarUrl: "")
        
        let sut = GFItemInfoVC(user: user, follower: follower)
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFRepoItemVCExists() {
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
        
        let follower = Follower(login: "jgmawecki", avatarUrl: "")
        
        let sut = GFRepoItemVC(user: user, follower: follower)
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testGFFollowerItemVCExists() {
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
        
        let follower = Follower(login: "jgmawecki", avatarUrl: "")
        
        let sut = GFFollowerItemVC(user: user, follower: follower)
        
        
        // Act
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
   

}
