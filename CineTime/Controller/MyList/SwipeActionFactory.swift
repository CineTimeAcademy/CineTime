//
//  SwipeActionFactory.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 19/07/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

protocol SwipeActionDelegate: class {
    func didDeleteRowAt(with item: Int, plist: String)
    func didMoveRowAt(with item: Int, by plistHost: String, to plistReceive: String)
}

class SwipeActionFactory {
    
    let index: Int!
    
    weak var delegate: SwipeActionDelegate?
    
    init(index: Int, tableView: UITableView, dataSource: [Movie]) {
        self.index = index
    }
    
    func createSwipeAction(item: Int) -> UISwipeActionsConfiguration {
        
        var configure: UISwipeActionsConfiguration
        
        let watched = UIContextualAction(style: .normal, title: nil) {
            (_, _, success) in
            self.delegate?.didMoveRowAt(with: item, by: PlistNames.watched.rawValue, to: PlistNames.toWatch.rawValue)
            success(true)
        }
        
        let toWatch = UIContextualAction(style: .normal, title: nil) { (_, _, success) in
            self.delegate?.didMoveRowAt(with: item, by: PlistNames.toWatch.rawValue, to:
                PlistNames.watched.rawValue)
            success(true)
        }
        
        let remove = UIContextualAction(style: .destructive, title: "Remove") { (_, _, success) in
            self.delegate?.didDeleteRowAt(with: item, plist: PlistNames.toWatch.rawValue)
            success(true)
        }
        
        switch index {
        case 0:
            toWatch.backgroundColor = .orange
            toWatch.title = "Já Assisti"
            configure = UISwipeActionsConfiguration(actions: [toWatch, remove])
        case 1:
            watched.backgroundColor = .orange
            watched.title = "Para Assistir"
            configure = UISwipeActionsConfiguration(actions: [watched])
        default:
            configure = UISwipeActionsConfiguration(actions: [toWatch])
            toWatch.backgroundColor = .orange
        }
        return configure
        
    }
}
