//
//  MyListHeaderView.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 10/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class MyListHeaderView: UIView {
    // Collection header names.
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = CGSize(width: 62, height: 22)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 16);
        
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
       
    lazy var segmentedControl: UISegmentedControl = {
           var segmentedControl = UISegmentedControl(items: ["Para Assistir", "Assistidos"])
           segmentedControl.translatesAutoresizingMaskIntoConstraints = false
           segmentedControl.selectedSegmentIndex = 0
           return segmentedControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
        segmentedControl.backgroundColor = .darkGray
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        
        buildViewHierarchy()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(segmentedControl)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            segmentedControl.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        
    }
}
