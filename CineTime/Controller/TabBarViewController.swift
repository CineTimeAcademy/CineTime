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
        
        let recommendationsVC = UINavigationController(rootViewController: RecommendationsViewController())
        recommendationsVC.tabBarItem = UITabBarItem(title: "Recomendações", image: UIImage(named: "rolinho"), tag: 0)
        
        let categoriesVC = UINavigationController(rootViewController: CategoriesViewController())
        categoriesVC.tabBarItem = UITabBarItem(title: "Buscar", image: UIImage(named: "buscar"), tag: 1)
        
        let myListVC = UINavigationController(rootViewController: MyListViewController())
        myListVC.tabBarItem = UITabBarItem(title: "Minha Lista", image: UIImage(named: "line.horizontal.3"), tag: 2)
        
        viewControllers = [recommendationsVC, categoriesVC, myListVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let navigations = viewControllers else { return }
        let navigation = navigations[item.tag] as? UINavigationController
        navigation?.popToRootViewController(animated: true)
    }


}
