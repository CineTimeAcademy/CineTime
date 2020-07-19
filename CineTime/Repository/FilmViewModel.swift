//
//  FilmViewModel.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 18/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

class FilmViewModel {
    
    var films: [Movie]?
    
    var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        films = self.repository.getAll()
    }
    
}
