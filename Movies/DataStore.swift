//
//  DataStore.swift
//  Movies
//
//  Created by Joel Alves on 22/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData

class DataStore{
    static let sharedInstance: DataStore = DataStore()
    let objectContext = CoreDataManager.sharedInstance.managedObjectContext
    
    private init() {
        
    }
    /*func getMovies()->[Movie]?{
        let usersFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        if let searchResults = try? objectContext.fetch(usersFetch) {
        //I like to check the size of the returned results!
            if !searchResults.isEmpty {
                print("Cria")
                return searchResults
            } else {
                return nil
            }
        }
       return nil
    }*/
    func getMovies(pedacoDeCodigoParaExecutarQuandoTiveresOsClientes: @escaping ([Movie]?)->()){
        let moviesFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        moviesFetch.predicate = NSPredicate(format: "type == %@", "movie")
        if let searchResults = try? objectContext.fetch(moviesFetch) {
            //I like to check the size of the returned results!
            if !searchResults.isEmpty {
                pedacoDeCodigoParaExecutarQuandoTiveresOsClientes(searchResults)
            }
        }
    }
    func getSeries(pedacoDeCodigoParaExecutarQuandoTiveresOsClientes: @escaping ([Movie]?)->()){
        let moviesFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        moviesFetch.predicate = NSPredicate(format: "type == %@", "tv")
        if let searchResults = try? objectContext.fetch(moviesFetch) {
            //I like to check the size of the returned results!
            if !searchResults.isEmpty {
                pedacoDeCodigoParaExecutarQuandoTiveresOsClientes(searchResults)
            }
        }
    }
    func removeMovie(object: Movie){
        objectContext.delete(object)
        do {
            try objectContext.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
            
        }
    }
    func removeAllMovie(){
        
        let usersFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        
        if let searchResults = try? objectContext.fetch(usersFetch) {
            //I like to check the size of the returned results!
            for object in searchResults {
                objectContext.delete(object)
            }
            do {
                try objectContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
                
            }
        }

    }
}
