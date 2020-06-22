//
//  MyListViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//
import UIKit

// sectionHeaderHeight & sectionHeaderWidth
extension MyListViewController {
    
    private enum CollectionViewSize: CGFloat {
        case height = 52.0
    }
    
    private enum HeaderSize: CGFloat {
        case height = 20.0
        case width = 24.0
    }
    
    private enum PlistNames: String {
        case watched = "FilmPlist"
        case toWatch = "PlistParaAssistir"
    }
    
}

class MyListViewController: UITableViewController {
    
    // Child View Controller
    let header = HeaderChildViewController()
    
    // Itens there are displayed, variable used to switch when click on Segmented Control
    lazy var rowToDisplay = assistidos
    
    // MARK: - TableView DataSource
    var assistidos: [Film] {
        return FilmRepository(with: PlistNames.watched.rawValue).getAll()
    }
    
    var paraAssistir: [Film] {
        return FilmRepository(with: PlistNames.toWatch.rawValue).getAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the Child ViewController
        setupHeader()
        
        // TableView delegates and setting TableViewHeader
        setupTableView()

        // Change color and large title from Navbar
        configureNavBar()
    }

   
    func setupHeader() {
        
        header.delegate = self
        // Add to header click actions
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
    
    private func configureNavBar() {
        view.backgroundColor = .black
        
        // Changing status bar color
        navigationController?.navigationBar.barStyle  = .black
        
        // Allows large title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Change title from rootViewController
        navigationItem.title = "Minha Lista"
        
        // Change large title color
         navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        // Change title color
        navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }

    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        
        let collectionHeight = CollectionViewSize.height.rawValue
        
        let headerHeight = header
            .systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height + collectionHeight
        
        switch self.header.headerView.segmentedControl.selectedSegmentIndex {
        case 0:
           header.frame.size.height = headerHeight
        case 1:
             header.frame.size.height = headerHeight - collectionHeight
        default:
            header.frame.size.height = headerHeight
        }
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
            tableView.sectionHeaderHeight = HeaderSize.height.rawValue
            updateHeaderViewHeight(for: tableView.tableHeaderView)
        default:
            rowToDisplay = assistidos
        }
        tableView.reloadData()
    }
    
}

// MARK: - TableView Implementation
extension MyListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier) as! MyListTableViewCell
        cell.selectionStyle = .none
        cell.film = rowToDisplay[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height = HeaderSize.height.rawValue
        let width = HeaderSize.width.rawValue
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = header.headerView.segmentedControl.selectedSegmentIndex
        let configure: UISwipeActionsConfiguration
        
        let alreadyWatch = UIContextualAction(style: .normal, title: nil) { (_, _, success) in
            self.deleteRowAt(indexPath: indexPath, by: PlistNames.watched.rawValue, to: PlistNames.toWatch.rawValue)
            success(true)
        }
        
        let notWatched = UIContextualAction(style: .normal, title: nil) { (_, _, success) in
            self.deleteRowAt(indexPath: indexPath, by: PlistNames.toWatch.rawValue, to:
            PlistNames.watched.rawValue)
            success(true)
        }
       
        switch index {
        case 0:
            alreadyWatch.backgroundColor = .orange
            alreadyWatch.title = "Já Assisti"
            configure = UISwipeActionsConfiguration(actions: [alreadyWatch])
        case 1:
            notWatched.backgroundColor = .red
            notWatched.title = "Remover"
            configure = UISwipeActionsConfiguration(actions: [notWatched])
        default:
            configure = UISwipeActionsConfiguration(actions: [notWatched])
            alreadyWatch.backgroundColor = .orange
            
        }
        return configure
    }
    
    func deleteRowAt(indexPath: IndexPath, by plistHost: String, to plistReceive: String) {
        let film = self.rowToDisplay[indexPath.row]
        tableView.beginUpdates()
        FilmRepository(with: plistHost).delete(object: film)
        FilmRepository(with: plistReceive).add(object: film)
        rowToDisplay.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
}

// Filter table View Delegate
extension MyListViewController: FilterDelegate {
    
    func didStartFilter(with streamings: [Streaming]) {
        let filteredStreamings = streamings.filter {
            $0.selected == true
        }
        
        if !filteredStreamings.isEmpty {
            var filteredMovies = [Film]()
            
            filteredStreamings.forEach { streaming in
                for film in assistidos where film.streaming == streaming.name {
                    filteredMovies.append(film)
                }
            }
            
            self.rowToDisplay = filteredMovies
            self.tableView.reloadData()
            
        } else {
            rowToDisplay = assistidos
            self.tableView.reloadData()
        }
    }
    
}
