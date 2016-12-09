//
//  User+CoreDataProperties.swift
//  Movies
//
//  Created by Joel Alves on 16/11/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var nome: String?
    @NSManaged public var password: String?
    @NSManaged public var numeroCliente: Int16
    @NSManaged public var movies: NSSet?
    @NSManaged public var location: Location?

}

// MARK: Generated accessors for movies
extension User {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
