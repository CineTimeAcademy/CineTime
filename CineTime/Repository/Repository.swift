//
//  Repository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

protocol Repository {
    
    func getAll() -> [Movie]
    func get(id: Int) -> Movie?
    func add(object: Movie)
    func update(object: Movie)
    func delete(object: Movie)
    
}
