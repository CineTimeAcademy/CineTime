//
//  poster.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct Movie {
    let posterName: String
}


struct FilmResult: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Film]
    
}

struct Film: Codable {
    
    let id: Int
    let title: String?
    let poster_path: String?
    let genre_ids: [Int]?
    let video: Bool = false
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    let media_type: String?
    
}

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

protocol Networking {
    var streaming: String { get set }
}

extension Film: Networking {
    
    var streaming: String {
        get {
            return "Netflix"
        }
        set {
            
        }
    }
}
