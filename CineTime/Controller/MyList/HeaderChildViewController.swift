//
//  HeaderViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 10/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func didStartFilter(with streamings: [Streaming])
}


class HeaderChildViewController: UIViewController {
    
    var streamings = [
        Streaming(name: "Prime Video"),
        Streaming(name: "Netflix"),
        Streaming(name: "Disney Plus"),
        Streaming(name: "Apple TV+"),
        Streaming(name: "Telecine")
    ]
    
    lazy var headerView: MyListHeaderView = {
        let header = MyListHeaderView(frame: .zero)
        header.collectionView.register(MyListCollectionViewCell.self, forCellWithReuseIdentifier: MyListCollectionViewCell.identifier)
        header.collectionView.delegate = self
        header.collectionView.dataSource = self
        return header
    }()
    
    weak var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        self.view = headerView
    }
    
}

extension HeaderChildViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let streaming = streamings[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCollectionViewCell.identifier, for: indexPath) as? MyListCollectionViewCell {
            cell.streamingTitle.text = streaming.name

            if streaming.selected {
                cell.selected()
                cell.isFiltering = true
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MyListCollectionViewCell {
            streamings[indexPath.row].selected = !streamings[indexPath.row].selected
            cell.switchStateWhenSelected()
            delegate?.didStartFilter(with: streamings)
        }
        
    }
    
}
