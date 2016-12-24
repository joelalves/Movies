//
//  SectionsData.swift
//  Movies
//
//  Created by Joel Alves on 22/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData

class SectionsData {
    let objectContext = CoreDataManager.sharedInstance.managedObjectContext;
    func getSectionsFromData() -> [Section] {
        
        // you could replace the contents of this function with an HTTP GET, a database fetch request,
        // or anything you like, as long as you return an array of Sections this program will
        // function the same way.
        
        var sectionsArray = [Section]()
        
        DataStore.sharedInstance.getMoviesUser { (movies) in
            let movies = Section(title: "Movies", objects: movies!)
            sectionsArray.append(movies)
        }
        DataStore.sharedInstance.getSeriesUser { (movies) in
            let movies = Section(title: "Series", objects: movies!)
            sectionsArray.append(movies)
        }
    
        return sectionsArray
    }
    
}
