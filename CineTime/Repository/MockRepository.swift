
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
        
        Film(id: 0, name: nil,
             title: "Teste 1",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streamings: [Streaming(name: "Netflix", display_name: "Netflix")]),
        
        Film(id: 1, name: nil,
             title: "Teste 2",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streamings: [Streaming(name: "Netflix", display_name: "Netflix")]),
        
        Film(id: 2, name: nil,
             title: "Teste 3",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streamings: [Streaming(name: "Netflix", display_name: "Netflix")]),
        
        Film(id: 3, name: nil,
             title: "Teste 4",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streamings: [Streaming(name: "Amazon", display_name: "Amazon")]),
        
        Film(id: 4, name: nil,
             title: "Teste 5",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streamings: [Streaming(name: "Amazon", display_name: "Amazon")]),
        
        Film(id: 5, name: nil,
             title: "Teste 6",
             poster_path: nil,
             genre_ids: nil,
             overview: nil,
             release_date: nil,
             vote_average: nil,
             media_type: nil, streamings: [Streaming(name: "Amazon", display_name: "Amazon")])
        
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
