//
//  FanartManager.swift
//  Movies
//
//  Created by Joel Alves on 21/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation
class FanartManager {
    private static let apiKey: String = "bf97c73cf3ef5d6689116bb8418b5857"
    
    static func images(for id: String, completion: @escaping (MovieImage)->()) {
        if let url = URL(string: "https://webservice.fanart.tv/v3/movies/\(id)?api_key=\(FanartManager.apiKey)") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
                if let data = data {
                    let json = JSON(data: data)
                    
                    if let poster = json["movieposter"][0]["url"].string {
                        completion(MovieImage(preview: poster.replacingOccurrences(of: "/fanart/", with: "/preview/"), full: poster))
                    }
                }
            }).resume()
        }
    }
}

