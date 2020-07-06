//
//  UINavigationBar+Configure.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 03/07/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func configure(title: String, largeTitle: Bool = true, tintColor: UIColor = .actionColor) {
        
        navigationBar.barStyle  = .black
        
        navigationBar.prefersLargeTitles = largeTitle
        
        navigationBar.tintColor = tintColor
        
        navigationItem.title = title
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        

        // Change title color
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    
}
