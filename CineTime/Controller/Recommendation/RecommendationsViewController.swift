//
//  RecommendationsViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {
    let indicationCollection = RecoCollectionView(frame: .zero, collectionViewLayout: ZoomAndSnapFlowLayout())
    let newsCollection = NewCollectionView(frame: .zero, collectionViewLayout: HorizontalFlowLayout())

    lazy var NewName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = "Lançamentos"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.viewControllers.first?.navigationItem.title = "Recomendações"
        
        navigationController?.navigationBar.tintColor = .actionColor
        
        // Change large title color from rootViewController 
        self.navigationController?.viewControllers.first?             .navigationController?.navigationBar.largeTitleTextAttributes = [                 NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle  = .black
    
        indicationCollection.delegatePush = self
        indicationCollection.translatesAutoresizingMaskIntoConstraints = false
        indicationCollection.backgroundColor = .black
        view.addSubview(indicationCollection)
        
        newsCollection.delegatePush = self
        newsCollection.backgroundColor = .black
        newsCollection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsCollection)
        

        view.addSubview(NewName)
        
        configureAutoLayout()
    }

    
    func configureAutoLayout() {
        // Indication collection.
        NSLayoutConstraint.activate([
            indicationCollection.topAnchor.constraint(equalTo: view.topAnchor),
            indicationCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicationCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicationCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 6/10)
        ])
        
        // Label new name.
        NSLayoutConstraint.activate([
            NewName.topAnchor.constraint(equalTo: indicationCollection.bottomAnchor, constant: 8),
            NewName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            NewName.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //News collection
        NSLayoutConstraint.activate([
            newsCollection.topAnchor.constraint(equalTo: NewName.bottomAnchor, constant: -40),
            newsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// Custom delegate to push the description screen.
extension RecommendationsViewController: DelegatePushDescriptionViewController {
    func didSelect(movie: Movie) {
        let destination = DescriptionViewController()
        destination.dataFilm = movie
        navigationController?.pushViewController(destination, animated: true)
    }
}
