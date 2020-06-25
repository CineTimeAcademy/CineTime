//
//  Service.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 15/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation
import UIKit

class Service {
    static let shared = Service()
    
    private init() { }
    
    func findFilmByGenre(with genresId: [String], completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .genre(id: genresId))
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                
            }
            
        }
        
    }
    
    func getTrailer(filmId: String,  completion: @escaping ([Trailer]?) -> Void) {
        
        let api = FilmsAPI(route: .trailer(id: filmId))
        
        guard let url = api.url else { return }
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(TrailerResult.self, from: data)
                let trailers = results.results
                completion(trailers)
            } catch {
                print(error)
            }
        }
    }
    
    func getRecomendations(filmId: String, completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .recommendations(id: filmId))
        
        guard let url = api.url else { return }
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
    func getTrendings(completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .latest)
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
    func nowPlaying(completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .nowPlaying)
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
                
            }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
    
    
    func searchByName(name: String, completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .searchByName(name: name))
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
        
    }
    
    
    func createList(list: FilmList) {
        
    }
    
}
 
