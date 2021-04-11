//
//  FollowersListVCTests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 11/04/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class FollowersListVCTests: XCTestCase {

    
    func testFollowersListVCExists() {
        // Arrange
        let sut     = FollowersListVC()
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
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut)
    }
    
    
    func testFollowerListVCCollectionViewExists() {
        // Arrange
        let sut = FollowersListVC()
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
        sut.loadViewIfNeeded()
        
        
        // Assert
        XCTAssertNotNil(sut.collectionView)
    }
    
//
//    func testFollowersListVCCollectionViewRowCountIs1() {
//        // Arrange
//        let sut     = FollowersListVC()
//        sut.user    = User(login:       "jmgawecki",
//                           avatarUrl:   "",
//                           name:        "Jakub",
//                           location:    "Warsaw",
//                           bio:         "Bio",
//                           publicRepos: 19,
//                           publicGists: 10,
//                           htmlUrl:     "",
//                           followers:   10,
//                           following:   10,
//                           createdAt:   "Test")
//
//
//        // Act
//        sut.loadViewIfNeeded()
//        let rowCount = sut.collectionView.numberOfItems(inSection: 0)
//        waitForExpectations(timeout: 5, handler: nil)
//
//
//        // Assert
//        XCTAssertEqual(rowCount, 1)
//    }
//
    
//    func testGetFollowersFunction() {
//        // Arrange
//        let sut     = FollowersListVC()
//        sut.user    = User(login:       "jmgawecki",
//                           avatarUrl:   "",
//                           name:        "Jakub",
//                           location:    "Warsaw",
//                           bio:         "Bio",
//                           publicRepos: 19,
//                           publicGists: 10,
//                           htmlUrl:     "",
//                           followers:   10,
//                           following:   10,
//                           createdAt:   "Test")
//        
//        // Act
//        sut.loadViewIfNeeded()
//        sut.getFollowers(page: 1, on: sut.user.login)
//        
//        
//        // assert
//        XCTAssertEqual(sut.followers.count, 1)
//        
//    }

}
