//
//  Book.swift
//  CoolBooks
//
//  Created by user197181 on 4/8/21.
//

import Foundation

class Book: CustomDebugStringConvertible, Codable {
    
//    placeholder to evaluate whether booktest works
//    var debugDescription: String {
//        return "wrong"
//    }
    var debugDescription: String {
        return "Book(name: \(self.name), genre: \(self.genre), description: \(self.description))"
    }
    
    var name: String
    var description: String
    var genre: String
    var confirmedGood: Bool = false
    var imageUrl: String
    var author: String
    var datePublished: String
    
    private enum CodingKeys: String, CodingKey {
        case name, description, genre, imageUrl, author, datePublished
    }
    
    init(named name: String, description: String, genre: String, imageUrl: String, author: String, datePublished: String) {
        self.name = name
        self.description = description
        self.genre = genre
        self.imageUrl = imageUrl
        self.author = author
        self.datePublished = datePublished
    }
}

struct BookResult: Codable {
    let books: [Book]
}


