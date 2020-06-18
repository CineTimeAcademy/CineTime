//
//  Repository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

protocol FilmRepository: class {
    
  func getAll() -> [Film]
  func get(id: Int) -> Film?
  func create(object: Film) -> Bool
  func update(object: Film) -> Bool
  func delete(object: Film) -> Bool
  
}
