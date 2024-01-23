//
//  Movie+CoreDataProperties.swift
//  Movies
//
//  Created by Joel Alves on 23/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie");
    }

    @NSManaged public var actors: String?
    @NSManaged public var director: String?
    @NSManaged public var duration: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: String?
    @NSManaged public var imdbRating: Double
    @NSManaged public var overview: String?
    @NSManaged public var poster: String?
    @NSManaged public var released: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var type: String?
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension Movie {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}
