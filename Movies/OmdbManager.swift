//
//  OmdbManager.swift
//  Movies
//
//  Created by Joel Alves on 10/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
import CoreData
class OmdbManager{
    private static let apiKey: String = "12443753391299fdc9235cf835a55188"
    
    static func trendingMovies(completion: @escaping ()->()) {
        print("#VamosMovies")
        if let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key="+apiKey+"&language=en-US&sort_by=popularity.desc") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let json = JSON(data: data)
                    if let movies = json["results"].array?.map({ (item) -> Movie? in
                        if let id = item["id"].stringValue as String?,
                            let title = item["original_title"].stringValue as String?,
                            let overview = item["overview"].stringValue as String?,
                            let vote_average = Double(item["vote_average"].stringValue),
                            let released = item["release_date"].stringValue as String?,
                            let poster_path = item["poster_path"].stringValue as String? {
                            
                            let year = (item["release_date"].string?.components(separatedBy: "-")[0])
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let date = dateFormatter.date(from:released)
                        
                            if DataStore.existElement(movieID: id),
                                    let movie = CoreDataManager.newObject(entityName: "Movie") as? Movie {
                                    movie.id = id
                                    movie.title = title
                                    movie.released = date as NSDate?
                                    movie.overview = overview
                                    movie.imdbRating = vote_average
                                    movie.poster = poster_path
                                    movie.year = year
                                    movie.type = "movie"
                                    return movie
                            }
                        }
                        return nil
                    }).filter({ $0 != nil }) as? [Movie] {
                        completion()
                    }
                   CoreDataManager.sharedInstance.saveContext()
                }
            }.resume()
        }
        
    }
    
    static func trendingSeries(completion: @escaping ()->()) {
        print("#VamosSeries")
        if let url = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key="+apiKey+"&language=en-US&sort_by=popularity.desc") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let json = JSON(data: data)
                    if let movies = json["results"].array?.map({ (item) -> Movie? in
                        if let id = item["id"].stringValue as String?,
                            let title = item["name"].stringValue as String?,
                            let overview = item["overview"].stringValue as String?,
                            let vote_average = Double(item["vote_average"].stringValue),
                            let released = item["first_air_date"].stringValue as String?,
                            let poster_path = item["poster_path"].stringValue as String? {
                    
                            let year = (item["first_air_date"].string?.components(separatedBy: "-")[0])
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let date = dateFormatter.date(from:released)
                            
                            if DataStore.existElement(movieID: id),
                                let movie = CoreDataManager.newObject(entityName: "Movie") as? Movie {
                               
                                movie.id = id
                                movie.title = title
                                movie.released = date as NSDate?
                                movie.overview = overview
                                movie.imdbRating = vote_average
                                movie.poster = poster_path
                                movie.year = year
                                movie.type = "tv"
                                return movie
                            }
                            
                        }
                        return nil
                    }).filter({ $0 != nil }) as? [Movie] {
                        completion()
                    }
                    CoreDataManager.sharedInstance.saveContext()
                }
            }.resume()
        }
        
    }
    
    
    
    static func getMovieFullInformation(movie: Movie, completion: @escaping (String)->()) {
        print("#getMovieFullInformation")
        print(movie.id!)
        if let url = URL(string: "https://api.themoviedb.org/3/\(movie.type!)/\(movie.id!)?api_key="+apiKey+"&language=en-US&sort_by=popularity.desc") {
            print(url)
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let json = JSON(data: data)
                    print("json")
                    print(json)
                    if let imdbId = json["imdb_id"].stringValue as? String {
                        completion("http://www.imdb.com/title/\(imdbId)")
                    }
                }
            }.resume()
        }
        
    }

}
