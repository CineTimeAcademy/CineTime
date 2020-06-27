//
//  RecomendationsUITests.swift
//  CineTimeUITests
//
//  Created by Brena Amorim on 26/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import XCTest
@testable import CineTime

class RecomendationsUITests: XCTestCase {
    
    func test_RecomendationButtons_actionables () {
        let app = XCUIApplication()
        
        app.launchArguments = ["-reset"]
        app.launch()
        
        
    }

}
