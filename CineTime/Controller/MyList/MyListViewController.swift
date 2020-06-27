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
        case watched = "assistidos"
        case toWatch = "paraAssistir"
    }
    
}

class MyListViewController: UITableViewController {
    
    // Child View Controller
    let header = HeaderChildViewController()
    
    // Itens there are displayed, variable used to switch when click on Segmented Control
    lazy var rowToDisplay = assistidos
    
    // MARK: - TableView DataSource
    var assistidos = [Film]()
    
    var paraAssistir = [Film]()
    
    func setToWatchModel(_ model: FilmViewModel) {
        if let films = model.films {
            rowToDisplay = films
        }
    }
    
    var filteredStreamings = [Streaming]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the Child ViewController
        setupHeader()
        
        // TableView delegates and setting TableViewHeader
        setupTableView()

        // Change color and large title from Navbar
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        rowToDisplay = paraAssistir
    }
 
    func fetchData() {
        paraAssistir = FilmRepository(with: PlistNames.toWatch.rawValue).getAll()
        assistidos = FilmRepository(with: PlistNames.watched.rawValue).getAll()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        
        navigationController?.navigationBar.tintColor = .actionColor
        
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
            fetchData()
            if self.filteredStreamings.isEmpty { rowToDisplay = paraAssistir } else {
                didStartFilter(with: filteredStreamings)
            }
            tableView.sectionHeaderHeight = 0
            updateHeaderViewHeight(for: tableView.tableHeaderView)
        case 1:
            fetchData()
            rowToDisplay = assistidos
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
        
        var film = rowToDisplay[indexPath.row]
        
        // saving image in plist
        if let path = film.poster_path {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
                else { return cell }

            // if exist image saved
            if let _ = film.imageData {
                cell.film = film
                return cell
            } else {
                film.downloaded(from: url) { data in
                    film.imageData = data
                    FilmRepository(with: PlistNames.toWatch.rawValue).update(object: film)
                    DispatchQueue.main.async() {
                        cell.film = film
                    }
                }
            }
        }
        cell.film = film
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height = HeaderSize.height.rawValue
        let width = HeaderSize.width.rawValue
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = rowToDisplay[indexPath.row]
        let destination = DescriptionViewController()
        destination.dataFilm = movie
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = header.headerView.segmentedControl.selectedSegmentIndex
        let configure: UISwipeActionsConfiguration
        
        let watched = UIContextualAction(style: .normal, title: nil) {
            (_, _, success) in
            self.deleteRowAt(indexPath: indexPath, by: PlistNames.watched.rawValue, to: PlistNames.toWatch.rawValue)
            success(true)
        }
        
        let toWatch = UIContextualAction(style: .normal, title: nil) { (_, _, success) in
            self.deleteRowAt(indexPath: indexPath, by: PlistNames.toWatch.rawValue, to:
            PlistNames.watched.rawValue)
            success(true)
        }
       
        switch index {
        case 0:
            toWatch.backgroundColor = .orange
            toWatch.title = "Já Assisti"
            configure = UISwipeActionsConfiguration(actions: [toWatch])
        case 1:
            watched.backgroundColor = .red
            watched.title = "Remover"
            configure = UISwipeActionsConfiguration(actions: [watched])
        default:
            configure = UISwipeActionsConfiguration(actions: [toWatch])
            toWatch.backgroundColor = .orange
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
    
    // Testar
    func didStartFilter(with streamings: [Streaming]) {
        let filteredStreamings = streamings.filter {
            $0.selected == true
        }
        
        self.filteredStreamings = filteredStreamings
        
        if !filteredStreamings.isEmpty {
            var filteredMovies = [Film]()
            print("Streamings que eu quero filtrar: \(filteredStreamings)")
            
            filteredStreamings.forEach { streaming in
                for film in rowToDisplay {
                    guard let streamingsArray = film.streamings else { return }
                    
                    for filmStreaming in streamingsArray {
                        
                        print("Streamings onde o filme está disponivel: \(filmStreaming)")
                        if filmStreaming.display_name == streaming.display_name {
                            if !filteredMovies.contains(film) {
                               filteredMovies.append(film)
                            }
                           
                            break
                        }
                    }
                }
            }
            
            self.rowToDisplay = filteredMovies
            self.tableView.reloadData()
            
        } else {
            rowToDisplay = paraAssistir
            self.tableView.reloadData()
        }
    }
    
}
