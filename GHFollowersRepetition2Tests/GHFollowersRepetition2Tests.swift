//
//  GHFollowersRepetition2Tests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import XCTest
//@testable import GHFollowersRepetition2
//@testable import

class GHFollowersRepetition2Tests: XCTestCase {
    var urlTest: URLSession!

    override func setUpWithError() throws {
        super.setUp()
        urlTest = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlTest = nil
        super.tearDown()
    }

    func testCallToGitHubCompleted() {
        // given
        let url = URL(string: "https://api.github.com/users/jmgawecki/followers?per_page=100&page=1")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        
        // when
        let dataTask = urlTest.dataTask(with: url!) { (data, response, error) in
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

}
