//
//  CategoryViewController.swift
//  CineTime
//
//  Created by Beatriz Carlos on 26/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        collectionView.backgroundColor = .purple
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categoria"
        view.addSubview(collectionView)
        configureAutoLayout()
        // Do any additional setup after loading the view.
    }
    
    func configureAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
