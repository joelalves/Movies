//
//  SectionsData.swift
//  Movies
//
//  Created by Joel Alves on 22/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation

class SectionsData {
    let objectContext = CoreDataManager.sharedInstance.managedObjectContext;
    func getSectionsFromData() -> [Section] {
        
        // you could replace the contents of this function with an HTTP GET, a database fetch request,
        // or anything you like, as long as you return an array of Sections this program will
        // function the same way.
        
        var sectionsArray = [Section]()
        
        //let movies = Section(title: "Animals", objects: ["Cats", "Dogs", "Birds", "Lions"])
        //let series = Section(title: "Vehicles", objects: ["Cars", "Boats", "Planes", "Motorcycles", "Trucks"])
        
        
        //sectionsArray.append(animals)
        //sectionsArray.append(vehicles)
        
        return sectionsArray
    }
}
