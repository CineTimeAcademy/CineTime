
//
//  MockRepository.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 23/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

class MockRepository: Repository {
    
    func getAll() -> [Film] {
        return [Film]()
    }
    
    func get(id: Int) -> Film? {
        return nil
    }
    
    func add(object: Film) {
        
    }
    
    func update(object: Film) {
        
    }
    
    func delete(object: Film) {
        
    }
    
    
}
