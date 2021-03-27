//
//  NetworkCallUnitTest.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 26/03/2021.
//

import XCTest
@testable import GHFollowersRepetition2

class NetworkCallUnitTest: XCTestCase {
    var urlFollowerTest:    URLSession!
    var urlUserTest:        URLSession!

    
    override func setUp() {
        super.setUp()
        urlFollowerTest     = URLSession(configuration: .default)
        urlUserTest         = URLSession(configuration: .default)
    }
    
    
    override func tearDown() {
        urlFollowerTest = nil
        urlUserTest     = nil
        super.tearDown()
    }
    
    
    func test_fetching_followers() {
        // given
        let url = URL(string: "https://api.github.com/users/jmgawecki/followers?per_page=100&page=1")
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = urlFollowerTest.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        // then
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
    func test_fetchin_user_info() {
        // given
        
        let url = URL(string: "https://api.github.com/users/jmgawecki")
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = urlUserTest.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        //then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
        xctassert
    }
    
    func test_fetching_image() {
        // given
        
        let url = URL(string: <#T##String#>)
    }
}
