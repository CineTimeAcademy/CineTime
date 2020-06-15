//
//  CategoriesViewController.swift
//  teste
//
//  Created by Beatriz Carlos on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "MyCell")
        return tableView
    }()
    
    let sectionsHeader : [String] = ["Ação", "Aventura", "Animação", "Comédia", "Crime", "Documentário", "Drama", "Fantasia", "Horror", "Musical", "Mistério", "Romance", "Ficção cientifica", "Suspense", "Séries", "Guerra", "Faroeste"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        view.backgroundColor = .black
        configureNavBar()
    }
    
    func configureNavBar() {
        self.navigationController?.viewControllers.first?.navigationItem.title = "Categorias"
        // Change large title color from rootViewController
        self.navigationController?.viewControllers.first?
            .navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationController?.navigationBar.barStyle = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor(red: 1.00, green: 0.86, blue: 0.30, alpha: 1.00)
        
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = UIColor(red: 1.00, green: 0.86, blue: 0.30, alpha: 1.00)
        } else {
            if let textField = searchController.value(forKey: "searchField") as? UITextField {
                textField.backgroundColor = UIColor(red: 1.00, green: 0.86, blue: 0.30, alpha: 1.00)
                //textField.font = myFont
                //textField.textColor = myTextColor
                //textField.tintColor = myTintColor
                // And so on...

                let backgroundView = textField.subviews.first
                if #available(iOS 11.0, *) { // If `searchController` is in `navigationItem`
                    backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.3) //Or any transparent color that matches with the `navigationBar color`
                    backgroundView?.subviews.forEach({ $0.removeFromSuperview() }) // Fixes an UI bug when searchBar appears or hides when scrolling
                }
                backgroundView?.layer.cornerRadius = 10.5
                backgroundView?.layer.masksToBounds = true
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView) // Add na sub view.
        setTableViewDelegates() // Setando a delegação.
        tableView.rowHeight = 200 // Altura de cada linha da table view.
        tableView.sectionHeaderHeight = 30
        tableView.backgroundColor = .black
        tableView.tableAutoLayout(to: view)  // setando as constraints da table view.
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeader.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderTableView()
        header.label.text = sectionsHeader[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! CategoriesTableViewCell
        cell.delegate = self
        
        return cell
    }
}

extension CategoriesViewController: DelegatePushDescriptionViewController {
    func didSelectItem() {
        let destination = DescriptionViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
}
