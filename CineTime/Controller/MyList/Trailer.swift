//
//  Trailer.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 15/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct TrailerResult: Decodable {
    let id: Int
    let result: [Trailer]
}

struct Trailer: Decodable {
    let id: Int
    let key: String
    let name: String
    let site: String
    let size: Int
}
