//
//  NetworkCallUnitTest.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 26/03/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class NetworkCallUnitTest: XCTestCase {
    
    
    func testFetchFollowersFromGitHubJson() {
        // Arrange
        let sut = URLSession(configuration: .default)
        let url = URL(string: "https://api.github.com/users/jmgawecki/followers?per_page=100&page=1")
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        
        var statusCode:     Int?
        var responseError:  Error?
        
        
        // Act
        let dataTask = sut.dataTask(with: url!) { (data, response, error) in
            statusCode      = (response as? HTTPURLResponse)?.statusCode
            responseError   = error
            expectation.fulfill()
            
            // Assert
            XCTAssertNil(responseError)
            XCTAssertEqual(statusCode, 200)
        }
        dataTask.resume()
        
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testFetchedFollowersFromGithubEqualTo1() {
        // Assert
        let sut         = URLSession(configuration: .default)
        let url         = URL(string: "https://api.github.com/users/jmgawecki/followers?per_page=1&page=1")
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        
        var followers:  [Follower] = []
        let decoder     = JSONDecoder()
        
        
        // Act
        let dataTask    = sut.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                followers                   = try decoder.decode([Follower].self, from: data)
            } catch {
                XCTFail("Catch block error")
            }
            
            expectation.fulfill()
            
            
            // Assert
            XCTAssertEqual(followers.count, 1)
        }
        dataTask.resume()
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testFetchUserInfoFromGitHubJson() {
        // Arrange
        let sut = URLSession(configuration: .default)
        let url = URL(string: "https://api.github.com/users/jmgawecki")
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        
        var statusCode:     Int?
        var responseError:  Error?
        
        
        // Act
        let dataTask = sut.dataTask(with: url!) { (data, response, error) in
            statusCode      = (response as? HTTPURLResponse)?.statusCode
            responseError   = error
            expectation.fulfill()
            
            // Assert
            XCTAssertNil(responseError)
            XCTAssertEqual(statusCode, 200)
        }
        dataTask.resume()
        
        wait(for: [expectation], timeout: 5)
    }
    
    
}
