//
//  Book.swift
//  CoolBooks
//
//  Created by user197181 on 4/8/21.
//

import Foundation

class Book {
    var name: String
    var description: String
    var genre: String
    var confirmedGood: Bool = false
    
    init(named name: String, description: String, genre: String) {
        self.name = name
        self.description = description
        self.genre = genre
    }
}

