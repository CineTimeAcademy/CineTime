//
//  MyListTests.swift
//  CineTimeTests
//
//  Created by Vinicius Mesquita on 23/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import XCTest

@testable import CineTime

class MyListTests: XCTestCase {

    var controller = MyListViewController()
    let repository = MockRepository()
    
    override func setUp() {
        let model = FilmViewModel(repository: repository)
//        controller.setToWatchModel(model)
        
        
    }

}
