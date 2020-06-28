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
    
    let id = "508439"
    let posterPath = "/jsi2UM64Mhr6NmY1LKeeCuZOaCo.jpg"
    
    func test_route_latestRoute_latestURL() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/latest?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR")
        let expect = expectation(description: "getting all latest movies")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.latest).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
        //Async
        
        wait(for: [expect], timeout: 5)
    }
    //por que n tem resume?
    
    func test_route_nowPlaying_nowPlayingURL() {

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR%3DBR&page=1" )
        let expect = expectation(description: "getting now playing")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.nowPlaying).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
        
        wait(for: [expect], timeout: 5)
    }
    
    // link que tem na API: https://api.themoviedb.org/3/movie/now_playing?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pr-BR&page=1
    
    func test_route_recomendationsURL() {
         let url = URL(string: "https://api.themoviedb.org/3/movie/508439/recommendations?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR&page=1" )
        let expect = expectation(description: "getting all recomendations")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.recommendations(id: id)).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
        
        wait(for: [expect], timeout: 5)
    }
    
    func test_route_trailer() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/508439/videos?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR" )
        let expect = expectation(description: "getting trailer")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.trailer(id: id, mediaType: "movie")).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
        
        wait(for: [expect], timeout: 5)
        
    }
    
    func test_route_genre() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=28&page=1&api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR")
        let expect = expectation(description: "getting films by genre")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.genre(id: ["28"])).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
              
        wait(for: [expect], timeout: 5)
    }
    
    func test_route_searchByName() {
        let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=a1d23d9e0cc08e49e4703408659fe47c&language=pt-BR&query=Vingadores&page=1")
        let expect = expectation(description: "getting films by name")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.searchByName(name: "Vingadores")).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
              
        wait(for: [expect], timeout: 5)
    }
    
    func test_route_getImageFilm() {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/jsi2UM64Mhr6NmY1LKeeCuZOaCo.jpg")
        let expect = expectation(description: "getting image films")
        guard let urlFilmAPI: URL = FilmsAPI(route: Router.getImageFilm(name: posterPath)).url else {return}
        XCTAssertEqual(url, urlFilmAPI)
        expect.fulfill()
              
        wait(for: [expect], timeout: 5)
       
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
