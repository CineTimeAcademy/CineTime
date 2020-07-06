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
        Streaming(name: "Prime Video", display_name: "Amazon Instant Video"),
        Streaming(name: "Netflix", display_name: "Netflix"),
        Streaming(name: "Disney Plus", display_name: "Disney+"),
        Streaming(name: "Apple TV+", display_name: "Apple TV Plus"),
        Streaming(name: "Telecine", display_name: "Telecine"),
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
    
//    @objc fileprivate func handleSegmentChange() {
//        switch headerView.segmentedControl.selectedSegmentIndex {
//        case 0:
//            delegate?.didChangeSegmentedControl(index: 0)
//        case 1:
//            delegate?.didChangeSegmentedControl(index: 1)
//        default:
//            print("Finish")
//        }
//    }
    
}

extension HeaderChildViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let streaming = streamings[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCollectionViewCell.identifier, for: indexPath) as? MyListCollectionViewCell {
            cell.streamingTitle.text = streaming.name

            if streaming.selected! {
                cell.selected()
                cell.isFiltering = true
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MyListCollectionViewCell {
            streamings[indexPath.row].selected = !streamings[indexPath.row].selected!
            cell.switchStateWhenSelected()
            delegate?.didStartFilter(with: streamings)
        }
        
    }
    
}
