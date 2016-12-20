//
//  OmdbManager.swift
//  Movies
//
//  Created by Joel Alves on 10/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
class OmdbManager{
    //private static let apiKey: String = "94cb42f60795c0aa22831db339fe55b9d347f6a6707a9264d4add852206c0baa"
    //private static let apiKey: String = "12443753391299fdc9235cf835a55188"
    
    static func trendingMovies(completion: @escaping ([Movie])->()) {
        print("#Vamos")
        if let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=12443753391299fdc9235cf835a55188&language=en-US&sort_by=popularity.desc") {
            let request = URLRequest(url: url)
            /*request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("2", forHTTPHeaderField: "trakt-api-version")
            request.addValue(OmdbManager.apiKey, forHTTPHeaderField: "trakt-api-key")*/
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                print("#VamosVamos")
                
                if let data = data {
                    print(data)
                    let json = JSON(data: data)
                    
                    print(json["page"])
                    print(json["results"])
                    
                    if let movies = json.array?.map({ (item) -> Movie? in
                        //print(item);
                        //if let title = item["movie"]["title"].string,
                           // let year = Int16(item["movie"]["year"].stringValue){
                           // return Movie(trakt:item["movie"]["ids"]["trakt"].stringValue, fanart:item["movie"]["ids"]["tmdb"].stringValue, title: title, year: year)
                        //}
                        return nil
                    }).filter({ $0 != nil }) as? [Movie] {
                        completion(movies)
                    }
                }
                }.resume()
        }
    }

}
