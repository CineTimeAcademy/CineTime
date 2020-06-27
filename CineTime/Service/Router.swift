//
//  Router.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 15/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation


enum Router {
    case trailer(id: String, mediaType: String)
    case genre(id: [String])
    case latest
    case nowPlaying
    case find(imdbId: String)
    case recommendations(id: String)
    case searchByName(name: String)
    case getImageFilm(name: String)
    case createList
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
            case .trailer(let id, let mediaType):
                return URL(string: "\(hostname)/\(mediaType)/\(id)/videos?api_key=\(key)&\(language)")
            case .find(let id):
                return URL(string: "\(hostname)/find/\(id)/api_key=\(key)&\(language)&external_source=imdb_id")
            case .recommendations(let id):
                return URL(string: "\(hostname)/movie/\(id)/recommendations?api_key=\(key)&\(language)&page=\(page)")
            case .latest:
                return URL(string: "\(hostname)/movie/latest?api_key=\(key)&\(language)")
            case .nowPlaying:
                return URL(string: "\(hostname)/movie/now_playing?api_key=\(key)&\(language)%3DBR&page=1")
            case .searchByName(let name):
                return URL(string: "\(hostname)/search/multi?api_key=\(key)&\(language)&query=\(name)&page=\(page)")
            case .getImageFilm(let name):
                return URL(string: "\(imageHostnane)/t/p/w500\(name)")
            case .createList:
                return URL(string: "\(hostname)/list?api_key=\(key)")
            }
        }
        
        /*
         Example genre request:
         https://api.themoviedb.org/3/discover/movie?with_genres=28&page=1&api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
         
         Example image request:
         https://image.tmdb.org/t/p/w500/vfzE3pjE5G7G7kcZWrA3fnbZo7V.jpg
         
         Example trailer request:
         https://api.themoviedb.org/3/movie/508439/videos?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
         
         https://api.themoviedb.org/3/tv/70523/videos?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR

         
         Example find request:
         https://api.themoviedb.org/3/find/{external_id}?api_key=<<api_key>>&language=en-US&external_source=imdb_id
         
         Example recommendations request:
         https://api.themoviedb.org/3/movie/{movie_id}/recommendations?api_key=<<api_key>>&language=en-US&page=1
         
         Example search by name:
         https://api.themoviedb.org/3/search/movie?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR&query=Vingadores&page=1
         */
    }
}
