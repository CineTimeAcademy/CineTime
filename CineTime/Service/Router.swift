//
//  Router.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 15/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation


enum Router {
    case trailer(id: String)
    case genre(id: [String])
}

struct FilmsAPI {
    
    let hostname: String = "https://api.themoviedb.org/3"
    let imageHostnane: String = "https://image.tmdb.org"
    
    var language: String = "pt-BR"
    let key: String = "a1d23d9e0cc08e49e4703408659fe47c"
    var page: Int = 1
    var route: Router
    
    var url: URL? {
        get {
            switch route {
            case .genre(let id):
                return URL(string: "\(hostname)/discover/movie?with_genres=\(id.joined(separator: ","))&page=\(page)&api_key=\(key)&language=\(language)")
            case .trailer(let id):
                return URL(string: "\(hostname)/movie/\(id)/videos?api_key=\(key)&language=\(language)")
            }
            
        }
    }
    
/*
     Example genre request:
     https://api.themoviedb.org/3/discover/movie?with_genres=28&page=1&api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
     
     Example image request:
     https://image.tmdb.org/t/p/w500/vfzE3pjE5G7G7kcZWrA3fnbZo7V.jpg
     
     Example video request:
     https://api.themoviedb.org/3/movie/454626/videos?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
 */
}
