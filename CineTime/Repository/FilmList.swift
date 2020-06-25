//
//  FilmList.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 18/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

// Not used
struct FilmList {
    let name: String
    let description: String
    let language: String? = "pt-BR"
}

// Not used
struct FilmMyList: Codable {
    let name: String
    let description: String
    let language: String? = "pt-BR"
    var results: [Film]
}


