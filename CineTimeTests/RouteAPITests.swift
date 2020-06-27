//
//  RouteAPITests.swift
//  CineTimeTests
//
//  Created by Vinicius Mesquita on 24/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import XCTest

@testable import CineTime

class RouteAPITests: XCTestCase {
    
    var filmAPI = FilmsAPI(route: Router.latest)
    
    func test_route_latestRoute_latestURL() {
        
        
    }
    
    func test_route_nowPlaying_nowPlayingURL() {
        let expected = ""
    }
    
}

/*
       Example genre request:
       https://api.themoviedb.org/3/discover/movie?with_genres=28&page=1&api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
       
       Example image request:
       https://image.tmdb.org/t/p/w500/vfzE3pjE5G7G7kcZWrA3fnbZo7V.jpg
       
       Example trailer request:
       https://api.themoviedb.org/3/movie/508439/videos?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR
       
       Example find request:
       https://api.themoviedb.org/3/find/{external_id}?api_key=<<api_key>>&language=en-US&external_source=imdb_id
       
       Example recommendations request:
       https://api.themoviedb.org/3/movie/{movie_id}/recommendations?api_key=<<api_key>>&language=en-US&page=1
       
       Example search by name:
       https://api.themoviedb.org/3/search/movie?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR&query=Vingadores&page=1
       */
