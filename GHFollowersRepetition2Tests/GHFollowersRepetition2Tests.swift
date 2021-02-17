//
//  GHFollowersRepetition2Tests.swift
//  GHFollowersRepetition2Tests
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import XCTest
@testable import GHFollowersRepetition2

class GHFollowersRepetition2Tests: XCTestCase {
    var sut: URLSession!

    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testCallToGitHubCompleted() {
        let url = URL(string: "https://api.github.com/users/jmgawecki/followers?per_page=100&page=1")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        
        
    }

}
