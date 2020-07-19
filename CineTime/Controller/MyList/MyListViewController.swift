//
//  MyListViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//
import UIKit

enum PlistNames: String {
    case watched = "assistidos"
    case toWatch = "paraAssistir"
}

class MyListViewController: UIViewController {
    
    // Header Child View Controller
    let headerViewController = MyListHeaderViewController()
    
    // Table View Child View Controller
    let tableViewController = MyListTableViewController()
    
    // Respositories
    let toWatchRepository = FilmRepository(with: PlistNames.toWatch.rawValue)
    let watchedRepository = FilmRepository(with: PlistNames.watched.rawValue)
    
    // Filter
    var filteredStreamings = [Streaming]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        setupTableView()
        
        fetchData()
        
        configureNavBar()
    }
    
    private func fetchData() {
        let toWatchFilms = toWatchRepository.getAll()
        let watchedFilms = watchedRepository.getAll()
        
        tableViewController.toWatch = toWatchFilms
        tableViewController.rowToDisplay = toWatchFilms
        
        tableViewController.watched = watchedFilms
    }
    
    private func setupTableView() {
        add(tableViewController)
        
        headerViewController.delegate = self
        
        headerViewController
            .headerView
            .segmentedControl
            .addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        add(headerViewController)
        
        tableViewController.tableView.tableHeaderView = headerViewController.view
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Minha Lista"
        navigationController?.navigationBar.tintColor = .actionColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableViewController.tableView.tableHeaderView)
    }
    
    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        
        let collectionHeight = CollectionViewSize.height.rawValue
        
        let headerHeight = header
            .systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height + collectionHeight
        
        switch self.headerViewController.headerView.segmentedControl.selectedSegmentIndex {
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
        
        switch headerViewController.headerView.segmentedControl.selectedSegmentIndex {
        case 0:
            fetchData()
            if self.filteredStreamings.isEmpty {
                tableViewController.rowToDisplay = tableViewController.toWatch
            } else {
                didStartFilter(with: filteredStreamings)
            }
            UserDefaults.standard.set(0, forKey: "SegmentIndex")
            tableViewController.tableView.sectionHeaderHeight = 0
            updateHeaderViewHeight(for: tableViewController.tableView.tableHeaderView)
        case 1:
            fetchData()
            tableViewController.rowToDisplay = tableViewController.watched
            tableViewController.tableView.sectionHeaderHeight = HeaderSize.height.rawValue
            updateHeaderViewHeight(for: tableViewController.tableView.tableHeaderView)
            UserDefaults.standard.set(1, forKey: "SegmentIndex")
        default:
            tableViewController.rowToDisplay = tableViewController.toWatch
        }
    }
}

extension MyListViewController: FilterDelegate {
    
    func didStartFilter(with streamings: [Streaming]) {
        
        let streamingsToFilter = streamings.filter {
            $0.selected == true
        }
        
        self.filteredStreamings = streamingsToFilter
        
        if !streamingsToFilter.isEmpty {
            
            var filteredMovies = [Movie]()
            
            // array de streaming do filme = array de streaming filtrada
            
            // todos os streamings do filme precisam conter em streaming filtradas
            
            filteredStreamings.forEach { streaming in
                for film in tableViewController.toWatch {
                    guard let streamingsArray = film.streamings else { return }
                    
                    for filmStreaming in streamingsArray {
                        if filmStreaming.display_name == streaming.display_name {
                            if !filteredMovies.contains(film) {
                                filteredMovies.append(film)
                            }
                        }
                    }
                }
            }
            tableViewController.rowToDisplay = filteredMovies
            
        } else {
            tableViewController.rowToDisplay = tableViewController.toWatch
        }
    }
    
}
