//
//  FilmRepository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 17/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

class FilmRepository: Repository {
    
    var plist: PlistManager<Film>
    
    init(with plistName: String) {
        plist = PlistManager<Film>(plistName: plistName)
    }
    
    func getAll() -> [Film] {
        
        // Getting films in plist
        if let films = plist.readPlist() {
            return films
        }
        
        return [Film]()
    }
    
    func get(id: Int) -> Film? {
        return nil
    }
    
    
    func add(object: Film) {
        
        // Saving in plist
        plist.addInPlist(object: object)
    }
    
    func update(object: Film) {
    
    }
    
    func delete(object: Film) {
        
        // deleting from plist
        if var plist = plist.readPlist() {
            plist = plist.filter { $0.id != object.id }
            self.plist.savePlist(object: plist)
        }
        
    }
    
}
