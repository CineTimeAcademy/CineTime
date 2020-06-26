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
    var streaming: String? = nil
    var imageData: Data? = nil
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
