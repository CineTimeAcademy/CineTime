//
//  TabBarViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    
    func setupTabBar() {
        
        let recommendationsVC = RecommendationsViewController()
        recommendationsVC.tabBarItem = UITabBarItem(title: "Recomendações", image: UIImage(named: "rolinho"), tag: 0)

        let categoriesVC = CategoriesViewController()
        categoriesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        
        let myListVC = MyListViewController()
        myListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        
        viewControllers = [recommendationsVC, categoriesVC, myListVC]
    }


}
