//
//  Repository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

protocol Repository {
    
    func getAll() -> [Film]
    func get(id: Int) -> Film?
    func add(object: Film)
    func update(object: Film)
    func delete(object: Film)
    
}

protocol RepositoryList {
    func createList(object: FilmMyList)
    func addToList(object: Film)
}
