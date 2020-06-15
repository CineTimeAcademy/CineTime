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
        
        self.tabBar.tintColor = .actionColor
        self.tabBar.barTintColor = .black
        
        let recommendationsVC = RecommendationsViewController()
        recommendationsVC.tabBarItem = UITabBarItem(title: "Recomendações", image: UIImage(named: "rolinho"), tag: 0)
        let categoriesVC = CategoriesViewController()
        
        categoriesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let myListVC = MyListViewController()
        myListVC.tabBarItem = UITabBarItem(title: "Minha Lista", image: UIImage(named: "line.horizontal.3"), tag: 2)
        
        viewControllers = [recommendationsVC, categoriesVC, myListVC]
    }


}
