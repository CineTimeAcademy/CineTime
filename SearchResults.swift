//
//  SearchResults.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 25/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let genre_ids: [Int]
    let video: Bool = false
    let overview: String
    let release_date: String
    let vote_average: Double
    let media_type: String
}
