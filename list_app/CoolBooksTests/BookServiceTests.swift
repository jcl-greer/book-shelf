//
//  BookServiceTests.swift
//  CoolBooksTests
//
//  Created by user197181 on 4/22/21.
//

import XCTest
@testable import CoolBooks

class BookServiceTests: XCTestCase {
    var systemUnderTest : BookService!

    override func setUpWithError() throws {
        self.systemUnderTest = BookService()
    }

    override func tearDownWithError() throws {
        self.systemUnderTest = nil
    }

    func testAPI_returnsSuccessfulResult() throws {
        
        var books: [Book]!
        var error: Error?
        let promise = expectation(description: "Completion handler is invoked")
        
        self.systemUnderTest.getBooks(completion: {data, shouldntHappen in
            books = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        XCTAssertNotNil(books)
        XCTAssertNil(error)

    }

}
