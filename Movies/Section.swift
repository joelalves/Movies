//
//  Section.swift
//  Movies
//
//  Created by Joel Alves on 22/12/16.
//  Copyright © 2016 Joel Alves. All rights reserved.
//

import Foundation

struct Section {
    
    var heading : String
    var items : [Movie]
    
    init(title: String, objects : [Movie]) {
        
        heading = title
        items = objects
    }
    mutating func delete(at: Int){
        self.items.remove(at: at)
    }
}
