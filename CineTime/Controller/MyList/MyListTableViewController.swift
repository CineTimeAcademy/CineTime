//
//  MyListTableViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 18/07/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class MyListTableViewController: UITableViewController {
    
    // Table View dataSource
    var watched = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var toWatch = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Itens there are displayed, variable used to switch when click on Segmented Control
    var rowToDisplay = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        self.tableView.backgroundColor = .black
        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: HeaderSize.width.rawValue, height: HeaderSize.height.rawValue))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier) as! MyListTableViewCell
        cell.selectionStyle = .none
        let film = rowToDisplay[indexPath.row]
        cell.film = film
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height = HeaderSize.height.rawValue
        let width = HeaderSize.width.rawValue
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderSize.height.rawValue
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = rowToDisplay[indexPath.row]
        let destination = DescriptionViewController()
        destination.dataFilm = movie
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = UserDefaults.standard.integer(forKey: "SegmentIndex")
        
        let factory = SwipeActionFactory(index: index, tableView: tableView, dataSource: rowToDisplay)
        factory.delegate = self
        
        let configure = factory.createSwipeAction(item: indexPath.item)
        return configure
    }
    
}

extension MyListTableViewController: SwipeActionDelegate {
    
    func didMoveRowAt(with item: Int, by plistHost: String, to plistReceive: String) {
        let film = self.rowToDisplay[item]
        tableView.beginUpdates()
        let repositoryHost = FilmRepository(with: plistHost)
        repositoryHost.delete(object: film)
        let repositoryRecieve = FilmRepository(with: plistReceive)
        repositoryRecieve.add(object: film)
        rowToDisplay.remove(at: item)
        
        let indexPath = IndexPath(item: item, section: 0)
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
    
    
    func didDeleteRowAt(with item: Int, plist: String) {
        let film = self.rowToDisplay[item]
        tableView.beginUpdates()
        FilmRepository(with: plist).delete(object: film)
        rowToDisplay.remove(at: item)
        let indexPath = IndexPath(item: item, section: 0)
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
    
}

enum CollectionViewSize: CGFloat {
    case height = 52.0
}

enum HeaderSize: CGFloat {
    case height = 20.0
    case width = 24.0
}
