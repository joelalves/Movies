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
        
        let moviesArray = getMovies()
        print("moviesArray")
        print(moviesArray.count)
       let movies = Section(title: "Movies", objects: moviesArray)
       // let series = Section(title: "Series", objects: ["Cars", "Boats", "Planes", "Motorcycles", "Trucks"])
        
        
       sectionsArray.append(movies)
       // sectionsArray.append(series)
        
        return sectionsArray
    }
    
    func getMovies() ->[Movie] {
        let usersFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            //go get the results
            if let searchResults = try? objectContext.fetch(usersFetch) {
                //I like to check the size of the returned results!
                if !searchResults.isEmpty {
                    return searchResults
                } else {
                    return []
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return []
    }
}
