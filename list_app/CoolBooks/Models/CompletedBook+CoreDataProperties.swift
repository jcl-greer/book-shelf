//
//  CompletedBook+CoreDataProperties.swift
//  
//
//  Created by user197181 on 5/24/21.
//
//

import Foundation
import CoreData


extension CompletedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompletedBook> {
        return NSFetchRequest<CompletedBook>(entityName: "CompletedBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var bookDescription: String?
    @NSManaged public var cover: String?
    @NSManaged public var review: String?
    @NSManaged public var genre: String?
    @NSManaged public var datePublished: String?
    @NSManaged public var isGood: Bool
    @NSManaged public var author: String?

}
