//
//  FilmRepository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

class LocalFilmRepository: FilmRepository {
    
    func getAll() -> [Film] {
        var films = [Film]()
        return films
    }
    
    func get(id: Int) -> Film? {
        return nil
    }
    
    func create(object: Film) -> Bool {
        return true
    }
    
    func update(object: Film) -> Bool {
        return true
    }
    
    func delete(object: Film) -> Bool {
        return true
    }
    
}
