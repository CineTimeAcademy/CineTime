//
//  UtellyRouter.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 25/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

enum UtellyRouter {
    case lookup(term: String)
    case idlookup(id: String)
}

struct UtellyAPI {
    
    let hostname: String = "https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com"
    let headers = [
        "x-rapidapi-host": "utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com",
        "x-rapidapi-key": "196ca2cb34mshfdaee870159c0d2p1e03dfjsnff9041512773"
    ]
    var country = "country=BR"
    
    var route: UtellyRouter
    
    var url: URL? {
        get {
            switch route {
            case .lookup(let term):
              return URL(string: "\(hostname)/lookup?term=\(term)&\(country)")
                
            case .idlookup(let id):
                return URL(string: "\(hostname)/idlookup?source_id=\(id)&source=tmdb")
            }
        }
    }
    
    // https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/lookup?term=bojack&country=uk
    
    // https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/idlookup?country=US&source_id=tt3398228&source=imdb
}
