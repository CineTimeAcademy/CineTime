//
//  HeaderViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 10/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {
    
    let streamings = ["Prime Video", "Netflix", "Disney plus", "Apple TV+", "Telecine Premium"]
    
    lazy var headerView: MyListHeaderView = {
        let header = MyListHeaderView(frame: .zero)
        header.collectionView.register(MyListCollectionViewCell.self, forCellWithReuseIdentifier: MyListCollectionViewCell.identifier)
        header.collectionView.delegate = self
        header.collectionView.dataSource = self
        return header
    }()
    
    override func viewDidLoad() {
        self.view = headerView
    }
    
}

extension HeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCollectionViewCell.identifier, for: indexPath) as! MyListCollectionViewCell
        cell.streamingTitle.text = streamings[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyListCollectionViewCell
        cell.switchStateWhenSelected(cell: cell)
        
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.backgroundColor = .clear
//    }
    
}
