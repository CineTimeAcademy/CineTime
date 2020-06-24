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
        // Model
        let model = FilmViewModel(repository: repository)
        controller.setToWatchModel(model)
    }
    
    func test_filter_filterNetflixMovie_movieCount3() {
        // given
        var netflix = Streaming(name: "Netflix")
        netflix.selected = true
        
        // when
        controller.didStartFilter(with: [netflix])
        let result = controller.rowToDisplay
        
        //then
        XCTAssertEqual(result.count, 3)
    }
    
    
    func test_filter_filterAmazonMovie_movieCount3() {
        // given
        var amazon = Streaming(name: "Amazon")
        amazon.selected = true
        
        // when
        controller.didStartFilter(with: [amazon])
        let result = controller.rowToDisplay
        
        //then
        XCTAssertEqual(result.count, 3)
    }
    
    
    func test_filter_filterMultiStreamingMovie_movieCount6() {
        // given
        var amazon = Streaming(name: "Amazon")
        var netflix = Streaming(name: "Netflix")
        netflix.selected = true
        amazon.selected = true
        
        let streamings = [amazon, netflix]
        
        // when
        controller.didStartFilter(with: streamings)
        let result = controller.rowToDisplay
        
        //then
        XCTAssertEqual(result.count, 6)
    }
    
    
}
