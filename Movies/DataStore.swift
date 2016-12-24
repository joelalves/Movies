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
    
    func getMovies(pedacoDeCodigoParaExecutarQuandoTiveresOsMovies: @escaping ([Movie]?)->()){
        let moviesFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        moviesFetch.predicate = NSPredicate(format: "type == %@", "movie")
        if let searchResults = try? objectContext.fetch(moviesFetch) {
            //I like to check the size of the returned results!
            if !searchResults.isEmpty {
                pedacoDeCodigoParaExecutarQuandoTiveresOsMovies(searchResults)
            }
        }
    }
    
    func getSeries(pedacoDeCodigoParaExecutarQuandoTiveresAsSeries: @escaping ([Movie]?)->()){
        let moviesFetch : NSFetchRequest<Movie> = Movie.fetchRequest()
        moviesFetch.predicate = NSPredicate(format: "type == %@", "tv")
        if let searchResults = try? objectContext.fetch(moviesFetch) {
            //I like to check the size of the returned results!
            if !searchResults.isEmpty {
                pedacoDeCodigoParaExecutarQuandoTiveresAsSeries(searchResults)
            }
        }
    }
    
    func getUser(pedacoDeCodigoParaExecutarQuandoTivereUser: @escaping (User?)->()){
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "userName") != nil) {
            let userFetch : NSFetchRequest<User> = User.fetchRequest()
            userFetch.predicate = NSPredicate(format: "nome == %@", defaults.string(forKey: "userName")!)
            if let searchResults = try? objectContext.fetch(userFetch) {
                //I like to check the size of the returned results!
                if !searchResults.isEmpty {
                    if let userLogged = searchResults[0] as? User {
                        pedacoDeCodigoParaExecutarQuandoTivereUser(userLogged)
                    }

                    
                }
            }
        }
    }
    
    func getMoviesUser(pedacoDeCodigoParaExecutarQuandoOUserTivereMovies: @escaping ([Movie]?)->()){
       
        DataStore.sharedInstance.getUser { (user) in
            
            let values = user!.movies!;
            var movies: [Movie] = []
            for obj in values {
                if let movie = obj as? Movie {
                    if (movie.type == "movie") {
                        movies.append(movie)
                    }
                }
            }
            pedacoDeCodigoParaExecutarQuandoOUserTivereMovies(movies)
        }
        
    }
    
    func getSeriesUser(pedacoDeCodigoParaExecutarQuandoOUserTivereSeries: @escaping ([Movie]?)->()){
        DataStore.sharedInstance.getUser { (user) in
            let values = user!.movies!;
            var movies: [Movie] = []
            for obj in values {
                if let movie = obj as? Movie {
                    if (movie.type == "tv") {
                        movies.append(movie)
                    }
                }
            }
            pedacoDeCodigoParaExecutarQuandoOUserTivereSeries(movies)
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
