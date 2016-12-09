//
//  Location+CoreDataProperties.swift
//  Movies
//
//  Created by Joel Alves on 16/11/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location");
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var user: User?

}
