//
//  MyListViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

// sectionHeaderHeight & sectionHeaderWidth

class MyListViewController: UIViewController {
    
    // Child View Controller
    let header = HeaderViewController()
    
    // TableView Configurations
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 0
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.tableHeaderView?.backgroundColor = .clear
        return tableView
    }()
    
    // Itens there are displayed, variable used to switch when click on Segmented Control
    lazy var rowToDisplay = assistidos
    
    // Action when click on segmented item
    @objc fileprivate func handleSegmentChange() {
        
        switch header.headerView.segmentedControl.selectedSegmentIndex {
        case 0:
            rowToDisplay = assistidos
            tableView.sectionHeaderHeight = 0
            updateHeaderViewHeight(for: tableView.tableHeaderView)
        case 1:
            rowToDisplay = paraAssistir
            tableView.sectionHeaderHeight = 20
            updateHeaderViewHeight(for: tableView.tableHeaderView)
        default:
            rowToDisplay = assistidos
        }
        tableView.reloadData()
    }
    
    // My TableView Data Source
    let assistidos = [
        "Star Wars: The Rise of Skywalker", "Solo: A Star Wars Story",
        "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story",
        "Star Wars: The Rise of Skywalker", "Solo: A Star Wars Story",
        "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story",
        "Star Wars: The Rise of Skywalker", "Solo: A Star Wars Story",
        "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story",
        "Solo: A Star Wars Story", "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story",
        "Star Wars: The Rise of Skywalker", "Solo: A Star Wars Story",
        "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story",
        "Solo: A Star Wars Story", "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story",
        "Star Wars: The Rise of Skywalker", "Solo: A Star Wars Story",
        "Star Wars: The Last Jedi",
        "Star Wars: The Force Awakens", "Rogue One: A Star Wars Story"
    ]
    
    let paraAssistir = [
        "Solo: A Star Wars Story"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Allows large title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        view.backgroundColor = .black
        
        // Change title from rootViewController
        self.navigationController?.viewControllers.first?.navigationItem.title = "Minha Lista"
        
        // Change large title color from rootViewController
        self.navigationController?.viewControllers.first?
            .navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        // Adding the Child ViewController
        setupHeader()
        
        // TableView delegates and setting TableViewHeader
        setupTableView()
        
        // All Constraints from TableView
        setupConstraints()
    }
    
    func setupHeader() {
        header
            .headerView
            .segmentedControl
            .addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        // Extension to add child ViewControllers
        add(header)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = header.view
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }

    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        
        let headerHeight = header
            .systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32, height: 0)).height + 52
        
        let collectionHeight = CGFloat(52.0)
        switch self.header.headerView.segmentedControl.selectedSegmentIndex {
        case 0:
           header.frame.size.height = headerHeight
        case 1:
             header.frame.size.height = headerHeight - collectionHeight
        default:
            header.frame.size.height = headerHeight
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    

}

// Implementation Of TableView
extension MyListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier) as! MyListTableViewCell
        cell.title.text = rowToDisplay[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        return view
    }
    
}
