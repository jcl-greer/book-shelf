//
//  BookTest.swift
//  CoolBooksTests
//
//  Created by user197181 on 4/22/21.
//

import XCTest
@testable import CoolBooks

class BookTest: XCTestCase {


    func testBookDebugDescription() throws {
        
        let subjectUnderTest = Book(
            named: "Piranesi",
            description: "This is the latest book I read",
            genre: "Speculative",
            imageUrl: "https://images-na.ssl-images-amazon.com/images/I/81H+7env6HL.jpg",
            author: "Susanna Clark",
            datePublished: "2020")
        
        let actualValue = subjectUnderTest.debugDescription
        
        let expectedValue = "Book(name: Piranesi, genre: Speculative, description: This is the latest book I read)"
        XCTAssertEqual(actualValue, expectedValue)
    }

}
