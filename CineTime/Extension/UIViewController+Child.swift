//
//  UIViewController+Child.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 10/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
}
