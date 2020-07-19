//
//  FilmRepository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

class FilmRepository: Repository {
    
    var plist: PlistManager<Movie>
    
    init(with plistName: String) {
        plist = PlistManager<Movie>(plistName: plistName)
    }
    
    func getAll() -> [Movie] {
        
        // Getting films in plist
        if let films = plist.readPlist() {
            return films
        }
        
        return [Movie]()
    }
    
    func get(id: Int) -> Movie? {
        return nil
    }
    
    
    func add(object: Movie) {
        
        // Saving in plist
        plist.addInPlist(object: object)
    }
    
    func update(object: Movie) {
        
        // update plist
        delete(object: object)
        add(object: object)
        
    }
    
    func delete(object: Movie) {
        
        // deleting from plist
        if var plist = plist.readPlist() {
            plist = plist.filter { $0.id != object.id }
            self.plist.savePlist(object: plist)
        }
        
    }
    
}
