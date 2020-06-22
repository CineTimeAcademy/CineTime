//
//  FilmList.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 18/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct FilmList {
    let name: String
    let description: String
    let language: String? = "pt-BR"
}

struct FilmMyList: Codable {
    let name: String
    let description: String
    let language: String? = "pt-BR"
    var results: [Film]
}


