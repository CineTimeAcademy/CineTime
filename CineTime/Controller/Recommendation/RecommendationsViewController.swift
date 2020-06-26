//
//  RecommendationsViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {
    let indicationColletion = RecoCollectionView(frame: .zero, collectionViewLayout: ZoomAndSnapFlowLayout())
    lazy var NewName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = "Lançamentos"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newsColletion = NewCollectionView(frame: .zero, collectionViewLayout: HorizontalFlowLayout())
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.viewControllers.first?.navigationItem.title = "Recomendações"
        
        // Change large title color from rootViewController 
        self.navigationController?.viewControllers.first?             .navigationController?.navigationBar.largeTitleTextAttributes = [                 NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle  = .black
        
        indicationColletion.delegatePush = self
        indicationColletion.translatesAutoresizingMaskIntoConstraints = false
        indicationColletion.backgroundColor = .black
        view.addSubview(indicationColletion)
        
        newsColletion.delegatePush = self
        newsColletion.backgroundColor = .black
        newsColletion.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsColletion)
        

        view.addSubview(NewName)
        
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        // Recomendações
        NSLayoutConstraint.activate([
            indicationColletion.topAnchor.constraint(equalTo: view.topAnchor),
            indicationColletion.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicationColletion.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicationColletion.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 6/10)
        ])
        
        // Label
        NSLayoutConstraint.activate([
            NewName.topAnchor.constraint(equalTo: indicationColletion.bottomAnchor, constant: 10),
            NewName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            NewName.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //
        NSLayoutConstraint.activate([
            newsColletion.topAnchor.constraint(equalTo: NewName.bottomAnchor, constant: -40),
            newsColletion.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsColletion.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsColletion.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// Custom delegate to push the description screen.
extension RecommendationsViewController: DelegatePushDescriptionViewController {
    func didSelect(movie: Film) {
        let destination = DescriptionViewController()
        destination.dataFilm = movie
        navigationController?.pushViewController(destination, animated: true)
    }
}
