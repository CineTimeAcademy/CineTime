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
    let name: String?
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


extension Film {
    
    // ajeitar isso pfvr
    func saveImage(with path: String) -> Data? {
        
        let not = URL(string: path)
        
        guard let url = not else { return nil }
        var teste = Data()
  
        return teste
         
        
    }
    
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
