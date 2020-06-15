//
//  CategoriesViewController.swift
//  teste
//
//  Created by Beatriz Carlos on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    // Table view.
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "MyCell")
        return tableView
    }()
    
    // Collection header names.
    let sectionsHeader : [String] = ["Ação", "Aventura", "Animação", "Comédia", "Crime", "Documentário", "Drama", "Fantasia", "Horror", "Musical", "Mistério", "Romance", "Ficção cientifica", "Suspense", "Séries", "Guerra", "Faroeste"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureTableView()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Changing status bar color
        navigationController?.navigationBar.barStyle  = .black
    }
    
    // configure navigation bar.
    func configureNavBar() {
        navigationItem.title = "Categorias"
    }
    
    // configure table view.
    func configureTableView() {
        view.addSubview(tableView) // Add na sub view.
        setTableViewDelegates() // Setando a delegação.
        tableView.rowHeight = 200 // Altura de cada linha da table view.
        tableView.sectionHeaderHeight = 30
        tableView.backgroundColor = .black
        tableView.tableAutoLayout(to: view)  // setando as constraints da table view.
    }
    
    // set delegates table view.
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

// Custom delegate to push the description screen.
extension CategoriesViewController: DelegatePushDescriptionViewController {
    func didSelectItem() {
//        let destination = DescriptionViewController()
//        navigationController?.pushViewController(destination, animated: true)
    }
}
