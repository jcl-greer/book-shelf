//
//  BookListViewControllerTests.swift
//  CoolBooksTests
//
//  Created by user197181 on 4/22/21.
//

import XCTest
@testable import CoolBooks

class BookListViewControllerTests: XCTestCase {
    
    var systemUnderTest: BookListViewController!

    override func setUpWithError() throws {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest =  navigationController.topViewController as? BookListViewController
        
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first!
            .rootViewController = self.systemUnderTest
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.systemUnderTest.view)
        
    }

    func testTableView_loadsBooks() throws {
        
        let mockBookService = MockBookService()
        let mockBooks = [
            Book(
            named: "Piranesi",
            description: "This is the latest book I read",
            genre: "Speculative",
            imageUrl: "https://images-na.ssl-images-amazon.com/images/I/81H+7env6HL.jpg",
            author: "Susanna Clark",
            datePublished: "2020"),
             Book(
                 named: "Piranesi 2: More Labyrinth",
                 description: "This is a fictional sequel",
                 genre: "Speculative",
                 imageUrl: "https://images-na.ssl-images-amazon.com/images/I/81H+7env6HL.jpg",
                 author: "Susanna Clark",
                 datePublished: "2022"),
            Book(
                named: "Piranesi 3: Most Labyrinth",
                description: "The Visionary end to the Trilogy",
                genre: "Speculative",
                imageUrl: "https://images-na.ssl-images-amazon.com/images/I/81H+7env6HL.jpg",
                author: "Susanna Clark",
                datePublished: "2024"),
        ]
        
        mockBookService.mockBooks = mockBooks
        
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.bookService = mockBookService
        
        XCTAssertEqual(0, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        self.systemUnderTest.viewWillAppear(false)
        
        
        XCTAssertEqual(mockBooks.count, self.systemUnderTest.books.count)
        XCTAssertEqual(mockBooks.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))

    }
    
    class MockBookService: BookService {
        var mockBooks: [Book]?
        var mockError: Error?
        
        override func getBooks(completion: @escaping ([Book]?, Error?) -> ()) {
            completion(mockBooks, mockError)
        }
    }

}
