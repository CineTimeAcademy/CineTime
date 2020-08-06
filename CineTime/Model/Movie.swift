//
//  poster.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct MovieResult: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Codable, Equatable {
    let id: Int
    let name: String?
    let title: String?
    let original_name: String? = nil
    let poster_path: String?
    let genre_ids: [Int]?
    let video: Bool = false
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    let media_type: String?
    var streamings: [Streaming]? = nil
    var imageData: Data? = nil
}

extension Movie {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
