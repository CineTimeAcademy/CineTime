//
//  MyListViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//
import UIKit

// sectionHeaderHeight & sectionHeaderWidth
class MyListViewController: UITableViewController {
    
    // Child View Controller
    let header = HeaderChildViewController()
    
    // Itens there are displayed, variable used to switch when click on Segmented Control
    lazy var rowToDisplay = assistidos
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Changing status bar color
        navigationController?.navigationBar.barStyle  = .black
        
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
    }
    
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
    let assistidos = [String]()
    
    let paraAssistir = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding the Child ViewController
        setupHeader()
        
        // TableView delegates and setting TableViewHeader
        setupTableView()
        
        // Teste de chamada
        callApi()
    }
    
    func callApi() {
        
        Service().findFilmByGenre(with: ["28", "12"]) { films in
            
            guard let films = films else { return }
            print(films)
            
            
        }
        
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
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header.view
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
    
}

// Implementation Of TableView
extension MyListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier) as! MyListTableViewCell
        cell.selectionStyle = .none
        cell.title.text = rowToDisplay[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
