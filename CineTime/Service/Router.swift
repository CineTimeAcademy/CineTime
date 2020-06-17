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
    case trending
    case find(imdbId: String)
    case recommendations(id: String)
    case searchByName(name: String)
    
}

struct FilmsAPI {
    
    let hostname: String = "https://api.themoviedb.org/3"
    let imageHostnane: String = "https://image.tmdb.org"
    
    var language: String = "language=pt-BR"
    let key: String = "a1d23d9e0cc08e49e4703408659fe47c"
    var page: Int = 1
    var route: Router
    
    var url: URL? {
        get {
            switch route {
            case .genre(let id):
                return URL(string: "\(hostname)/discover/movie?with_genres=\(id.joined(separator: ","))&page=\(page)&api_key=\(key)&\(language)")
            case .trailer(let id):
                return URL(string: "\(hostname)/movie/\(id)/videos?api_key=\(key)&\(language)")
            case .find(let id):
                return URL(string: "\(hostname)/find/\(id)/api_key=\(key)&\(language)&external_source=imdb_id")
            case .recommendations(let id):
                return URL(string: "\(hostname)/movie/\(id)/recommendations?api_key=\(key)&\(language)&page=\(page)")
            case .trending:
                return URL(string: "\(hostname)/trending/movie/week?api_key=\(key)&\(language)")
            
            case .searchByName(let name):
                return URL(string: "\(hostname)/search/movie?api_key=\(key)&\(language)&query=\(name)&page=\(page)")
            }
        }
        
        /*
         Example genre request:
         https://api.themoviedb.org/3/discover/movie?with_genres=28&page=1&api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
         
         Example image request:
         https://image.tmdb.org/t/p/w500/vfzE3pjE5G7G7kcZWrA3fnbZo7V.jpg
         
         Example video request:
         https://api.themoviedb.org/3/movie/454626/videos?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
         
         Example find request:
         https://api.themoviedb.org/3/find/{external_id}?api_key=<<api_key>>&language=en-US&external_source=imdb_id
         
         Example recommendations request:
         https://api.themoviedb.org/3/movie/{movie_id}/recommendations?api_key=<<api_key>>&language=en-US&page=1
         
         Example trainding request:
         https://api.themoviedb.org/3/trending/movie/week?api_key=a1d23d9e0cc08e49e4703408659fe47c
         
         Example search by name:
         
         https://api.themoviedb.org/3/search/movie?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR&query=Vingadores&page=1
         */
    }
}
