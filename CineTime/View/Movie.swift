//
//  poster.swift
//  CineTime
//
//  Created by Leonardo Gomes on 14/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct FilmResult: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Film]
}

struct Film: Codable, Equatable {
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

extension Film {
    static func ==(lhs: Film, rhs: Film) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Film {
    
    func downloaded(from url: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else { return }
            completion(data)
        }.resume()
    }
}
