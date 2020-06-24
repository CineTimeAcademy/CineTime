
//
//  MockRepository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 23/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

class MockRepository: Repository {
    
    var films = [
        
        Film(id: 0, title: "Teste 1",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streaming: "Netflix"),
        
        Film(id: 0, title: "Teste 2",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streaming: "Netflix"),
        
        Film(id: 0, title: "Teste 3",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streaming: "Netflix"),
        
        Film(id: 0, title: "Teste 4",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streaming: "Amazon"),
        
        Film(id: 0, title: "Teste 5",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streaming: "Amazon"),
        
        Film(id: 0, title: "Teste 6",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streaming: "Amazon")
        
    ]
    
    func getAll() -> [Film] {
        return films
    }
    
    func get(id: Int) -> Film? {
        return nil
    }
    
    func add(object: Film) {
        
    }
    
    func update(object: Film) {
        
    }
    
    func delete(object: Film) {
        
    }
    
    
}
