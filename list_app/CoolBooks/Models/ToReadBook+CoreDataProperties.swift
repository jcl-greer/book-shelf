//
//  ToReadBook+CoreDataProperties.swift
//  
//
//  Created by user197181 on 5/24/21.
//
//

import Foundation
import CoreData


extension ToReadBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToReadBook> {
        return NSFetchRequest<ToReadBook>(entityName: "ToReadBook")
    }

    @NSManaged public var author: String?
    @NSManaged public var bookDescription: String?
    @NSManaged public var cover: String?
    @NSManaged public var datePublished: String?
    @NSManaged public var genre: String?
    @NSManaged public var isGood: Bool
    @NSManaged public var title: String?

}
